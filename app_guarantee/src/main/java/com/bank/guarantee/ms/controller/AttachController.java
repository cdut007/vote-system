package com.bank.guarantee.ms.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import com.bank.guarantee.ms.entity.AttachEntity;
import com.bank.guarantee.ms.service.AttachService;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.R;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * 附件表
 *
 * @author james
 * @email 316458704@qq.com
 * @date 2019-05-16 13:29:05
 */
@RestController
@RequestMapping("ms/attach")
public class AttachController extends AbstractController{
    private Logger logger = LoggerFactory.getLogger(AttachController.class);

    @Autowired
    private AttachService attachService;



    private String prepareDownloadName(HttpServletRequest request, String documentName) throws UnsupportedEncodingException {
        String header = request.getHeader("User-Agent").toUpperCase();
        if (header.contains("MSIE") || header.contains("TRIDENT") || header.contains("EDGE")) {
            documentName = URLEncoder.encode(documentName, "utf-8");
            documentName = documentName.replace("+", "%20");    //IE下载文件名空格变+号问题
        } else {
            documentName = new String(documentName.getBytes(), "ISO8859-1");
        }
        return documentName;
    }

    /**
     * 保存
     */
    @ApiOperation(value = "上传文件并记录信息", notes = "上传文件并记录关联信息")
    @RequestMapping(value = "upload", method = RequestMethod.POST)
    @Transactional(rollbackFor = Exception.class)
    public R upload(MultipartFile file, String fileGroupId) throws Exception {
        try {
            String contentType = file.getContentType();
            long size = file.getSize();
            logger.info("【文件上传】contentType=="+contentType+";size="+size);
            AttachEntity ety = attachService.parse2Attachment(file.getOriginalFilename(), file.getInputStream());
            //保存到数据库中
            ety.setGroupId(fileGroupId);
            ety.setUploadUserId(getUserId());
            attachService.insert(ety);
            Map<String,Object> result = new HashMap<>();
            result.put("status", true);
            result.put("data", ety);
            return R.ok(result);
        } catch (Exception ex) {
            logger.error("文件上传失败：", ex);
            Map<String,Object> result = new HashMap<>();
            result.put("status", false);
            result.put("msg", "文件上传失败");
            return  R.ok(result);
        }
    }


    /**
     * 删除文件
     *
     * @return
     */
    @ApiOperation(value = "删除文件", notes = "删除文件")
    @RequestMapping(value = "deleteFile", method = RequestMethod.POST)
    public R deleteFile(String attachmentId) throws Exception {
        try {
            boolean delete = attachService.deleteById(attachmentId);
            Map<String,Object> result = new HashMap<>();
            result.put("status", true);
            result.put("data", delete);
            return R.ok(result);
        } catch (Exception ex) {
            logger.error("删除文件失败：", ex);
            Map<String,Object> result = new HashMap<>();
            result.put("status", false);
            result.put("msg", "删除文件失败："+ex.getLocalizedMessage());
            return  R.ok(result);
        }
    }



    /**
     * 下载文件
     *
     * @param attachmentId
     * @return
     */
    @ApiImplicitParam(name = "attachmentId", value = "附件ID", required = true, dataType = "String", paramType = "query")
    @ApiOperation(value = "下载文件", notes = "下载文件")
    @RequestMapping(value = "download", method = RequestMethod.GET)
    public void download(String attachmentId, HttpServletResponse response, HttpServletRequest request) throws Exception {

        try {
            AttachEntity attachment = attachService.selectById(attachmentId);

            if (attachment == null) {
                throw new Exception("未找到附件信息");
            }
            String path = attachment.getPath();
            response.reset();
            response.setContentType(attachment.getContentType());
            response.setContentLength(attachment.getLength().intValue());
            response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
            response.setHeader("Content-Disposition", "attachment;filename=" + prepareDownloadName(request, attachment.getFileName()));

            File file = new File(path);
            BufferedInputStream bufferedInputStream = new BufferedInputStream(new FileInputStream(file));
            IOUtils.copy(bufferedInputStream, response.getOutputStream());

            if (!file.exists()) {
                throw new Exception("文件不存在");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }


    /**
     * 根据附件id查询附件
     */
    @ApiImplicitParam(name = "id", value = "附件ID", required = true, dataType = "String", paramType = "query")
    @ApiOperation(value = "附件id查询附件", notes = "附件id查询附件")
    @RequestMapping(value = "getOne", method = RequestMethod.GET)
    public R getOneById(String id) {
        AttachEntity attach = attachService.selectById(id);
        Map<String, Object> result = new HashMap<>();
        result.put("status", true);
        result.put("data", attach);
        return R.ok(result);
    }


    /**
     * 根据附件组id查询附件集合
     */
    @ApiImplicitParam(name = "groupId", value = "附件组ID", required = true, dataType = "String", paramType = "query")
    @ApiOperation(value = "附件id查询附件", notes = "附件id查询附件")
    @RequestMapping(value = "getList", method = RequestMethod.GET)
    public R getListByGroupId(String groupId) {
        Map<String, Object> result = new HashMap<>();
        if(groupId==null){
            result.put("status", false);
            return R.ok(result);
        }

        List<AttachEntity> attachList = attachService.findAttachByGroupId(groupId);
        result.put("status", true);
        result.put("data", attachList);
        return R.ok(result);
    }


    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = attachService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") String id){
			AttachEntity attach = attachService.selectById(id);

        return R.ok().put("attach", attach);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody AttachEntity attach){
			attachService.insert(attach);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody AttachEntity attach){
			attachService.updateById(attach);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody String[] ids){
			attachService.deleteBatchIds(Arrays.asList(ids));

        return R.ok();
    }

}
