package com.itender.ms.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageInfo;
import com.itender.ms.convert.LayuiTableData;
import com.itender.ms.convert.PageDataConvert;
import com.itender.ms.domain.*;
import com.itender.ms.enums.ReviewRole;
import com.itender.ms.enums.ReviewSignType;
import com.itender.ms.enums.ReviewType;
import com.itender.ms.exception.APIException;
import com.itender.ms.service.ItenderReviewService;
import com.itender.ms.service.ItenderUserService;
import com.itender.ms.util.CommonUtility;
import com.itender.ms.util.HttpHelper;
import com.itender.ms.util.ViewUtil;
import com.itextpdf.text.pdf.BaseFont;
import fr.opensagres.xdocreport.itext.extension.font.IFontProvider;
import fr.opensagres.xdocreport.itext.extension.font.ITextFontRegistry;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.poi.xwpf.converter.pdf.PdfConverter;
import org.apache.poi.xwpf.converter.pdf.PdfOptions;
import org.apache.poi.xwpf.usermodel.*;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.hibernate.validator.constraints.NotEmpty;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.ClassUtils;
import org.springframework.util.ResourceUtils;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import springfox.documentation.annotations.ApiIgnore;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.*;
import java.net.URL;
import java.net.URLDecoder;
import java.util.*;
import java.util.List;

@Api(description = "审批管理模块接口")
@Validated
@Controller
@RequestMapping("/review")
public class ReviewController {
	 private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ItenderReviewService itenderReviewService;


    @Autowired
    private ItenderUserService itenderUserService;

    @Autowired
    private HttpHelper httpHelper;


    @ApiIgnore
    @RequestMapping("")
    public String index(HttpServletRequest request,HttpServletResponse response){
        return "review/review_main";
    }

    @ApiIgnore
    @RequestMapping("/review")
    public String review(HttpServletRequest request,HttpServletResponse response){
        return "review/review_main";
    }


    @ApiIgnore
    @RequestMapping(value = "",method = RequestMethod.GET)
    public String reviewPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_main");
    }



    @ApiIgnore
    @RequestMapping(value = "/review_all_list",method = RequestMethod.GET)
    public String reviewAllListPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_all_list");
    }


    @ApiIgnore
    @RequestMapping(value = "/review_list",method = RequestMethod.GET)
    public String reviewListPage(HttpServletRequest request, HttpServletResponse response){
        return ViewUtil.forward("/review/review_list");
    }


    @ApiIgnore
    @RequestMapping(value = "/review_scan",method = RequestMethod.GET)
    public String reviewScanPage(HttpServletRequest request, HttpServletResponse response){
        String attachId = request.getParameter("attachId");
        if(!StringUtils.isEmpty(attachId)){

            try {
                request.setAttribute("attach",itenderReviewService.findAttachByAttachId(attachId));
            }catch (Exception e){
                e.printStackTrace();
            }
        }else{
            String referenceAttachId = request.getParameter("referenceAttachId");
            try {
                request.setAttribute("attach",itenderReviewService.findAttachByReferenceAttachId(referenceAttachId));
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return ViewUtil.forward("/review/review_scan_file");
    }



    @ApiIgnore
    @RequestMapping(value = "/review_sign",method = RequestMethod.GET)
    public String reviewSignPage(HttpServletRequest request, HttpServletResponse response){
        String confirmId = request.getParameter("confirmId");

        try {
            request.setAttribute("confirm",itenderReviewService.findConfirmByConfirmId(confirmId));
        }catch (Exception e){
            e.printStackTrace();
        }
        return ViewUtil.forward("/review/review_sign");
    }


    @ApiIgnore
    @RequestMapping(value = "/review_all_detail",method = RequestMethod.GET)
    public String reviewAllDetailPage(HttpServletRequest request, HttpServletResponse response){
        String reviewId = request.getParameter("id");
        ItenderReview review = null;
        if(CommonUtility.isNonEmpty(reviewId)){
            review = itenderReviewService.findById(reviewId);
        }

        request.setAttribute("itenderReview",review);

        return ViewUtil.forward("/review/review_all_detail");
    }

    @ApiIgnore
    @RequestMapping(value = "/review_detail",method = RequestMethod.GET)
    public String reviewDetailPage(HttpServletRequest request, HttpServletResponse response){
        String reviewId = request.getParameter("id");
        ItenderReview review = null;
        if(CommonUtility.isNonEmpty(reviewId)){
            review = itenderReviewService.findById(reviewId);
        }

        request.setAttribute("itenderReview",review);

        return ViewUtil.forward("/review/review_detail");
    }

    @ApiOperation(value = "获取签章列表信息",notes = "获取签章列表信息")
    @RequestMapping(value = "/getSignList",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> getSignList(HttpServletRequest request,
                                                               @ApiParam(name = "confirmId",value = "confirmId",required = true) @RequestParam(required = true) String confirmId
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        if(confirmId == null || confirmId.equals("")){
            result.put("status", false);
            result.put("msg", "获取签章列表信息失败！");
            return ResponseEntity.ok(result);
        }
        List<ItenderSign> itenderSigns = itenderReviewService.findSignsByConfirmId(confirmId);
        if(itenderSigns == null){
            result.put("status", false);
            result.put("msg", "获取签章列表信息失败！");
        }else{
            for (int i = 0; i < itenderSigns.size(); i++) {
                ItenderSign itenderSign = itenderSigns.get(i);
                ItenderUser itenderUser = itenderUserService.findByUserId(itenderSign.getSignId());
                if(itenderUser!=null){
                    itenderSign.setDescription(itenderUser.getPosition()+": "+itenderSign.getDescription());
                }

            }

            result.put("status", true);
        }
        result.put("data", itenderSigns);
        return ResponseEntity.ok(result);
    }
//
//    private String getPosition(String position) {
//
//        if( ReviewRole.operator.name().equals(position)){
//            return  "经办人";
//        }else if(ReviewRole.department_leader.name().equals(position)){
//            return  "科室负责人";
//        }else if(ReviewRole.branch_leader.name().equals(position)){
//            return  "分管负责人";
//        }else if(ReviewRole.approver.name().equals(position)){
//            return  "审批人";
//        }
//        return  "审批人";
//    }


    @ApiOperation(value = "审批文件接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/confirms",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> confirms(HttpServletRequest request,
                                                    @RequestParam(required = false) String id
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");

        if(user == null){
            result.put("status", false);
            result.put("msg", "用户不存在，查询审批失败！");
            return ResponseEntity.ok(result);
        }
        itenderReviewService.setCurrentUser(user);
        ItenderReview review = itenderReviewService.findById(id);

        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review.getConfirms());

        return ResponseEntity.ok(result);

   }

    @ApiOperation(value = "审批文件附件接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/attaches",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> attachs(HttpServletRequest request,
                                                       @RequestParam(required = false) String id
    ) throws APIException{

        ItenderReview review = itenderReviewService.findById(id);
        Map<String,Object> result = new HashMap<>();
        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review.getAttaches());

        return ResponseEntity.ok(result);

    }



    @ApiOperation(value = "审批列表接口",notes = "用于查询所有审批信息")
    @RequestMapping(value = "/listReview",method = RequestMethod.POST)
    public ResponseEntity<LayuiTableData> reviewAll(HttpServletRequest request,
                                                       @RequestParam(required = false) Integer pageNum,
                                                       @RequestParam(required = false) Integer pagesize,
                                                    @RequestParam(required = false) String keyword,
                                                    @RequestParam(required = false) boolean all
    ) throws APIException{
        ItenderUser user=null ;
        if(!all){
             user = (ItenderUser)request.getSession().getAttribute("user");

            if(user == null){
                return ResponseEntity.ok(PageDataConvert.convertToLayuiData(new PageInfo(),200,"success"));
            }
        }


        pageNum = pageNum == null?1:pageNum;
        pagesize = pagesize == null?10:pagesize;

        PageInfo<ItenderReview> page = null;
        itenderReviewService.setCurrentUser(user);
        itenderReviewService.setSearchInfo(keyword);
        page = itenderReviewService.findPage(pageNum, pagesize);

        return ResponseEntity.ok(PageDataConvert.convertToLayuiData(page,200,"success"));
    }

    @ApiIgnore
    @RequestMapping(value = "/add_page",method = RequestMethod.GET)
    public String addReviewPage(HttpServletRequest request,HttpServletResponse response){

        return ViewUtil.forward("review/review_add");
    }


    @ApiIgnore
    @RequestMapping(value = "/choose_operator_page",method = RequestMethod.GET)
    public String chooseOperatorPage(HttpServletRequest request,HttpServletResponse response){
        String operator = request.getParameter("operator");
        String id = request.getParameter("id");
        List<ItenderUser> itenderUsers = itenderUserService.findByUserOperator(operator);
        request.setAttribute("id",id);
        request.setAttribute("itenderUsers",itenderUsers);
        return ViewUtil.forward("review/choose_operator");
    }


    @ApiIgnore
    @RequestMapping(value = "/edit_page",method = RequestMethod.GET)
    public String editReviewPage(HttpServletRequest request,HttpServletResponse response){
        String reviewId = request.getParameter("id");
        ItenderReview review = null;
        if(CommonUtility.isNonEmpty(reviewId)){
            review = itenderReviewService.findById(reviewId);
        }
        request.setAttribute("itenderReview",review);
        return ViewUtil.forward("review/review_edit");
    }


    public static boolean isLinux(String OS){
        return OS.indexOf("linux")>=0;
    }

    public static boolean isMacOS(String OS){
        return OS.indexOf("mac")>=0&&OS.indexOf("os")>0&&OS.indexOf("x")<0;
    }

    public static boolean isMacOSX(String OS){
        return OS.indexOf("mac")>=0&&OS.indexOf("os")>0&&OS.indexOf("x")>0;
    }

    public static boolean isWindows(String OS){
        return OS.indexOf("windows")>=0;
    }



    @RequestMapping(value = "/getAttachFile", method = RequestMethod.GET)
    public void getAttachFile(HttpServletRequest request,HttpServletResponse res) throws Exception{


        Map<String, String> datas = new HashMap<String, String>();

        String attachId = request.getParameter("id");

        ItenderAttach itenderAttach = itenderReviewService.findAttachByAttachId(attachId);

        if(itenderAttach == null){
            throw new Exception("attach file not find");
        }
        File attachFile = new File(getFileDirByName("attach_files")+File.separator+itenderAttach.getName()+"."+itenderAttach.getType());
        String fileName = null;
        File outFile = null;
        fileName = attachFile.getName();
        outFile = attachFile;


        res.setHeader("content-type", "application/octet-stream");
        res.setContentType("application/octet-stream");
        res.setHeader("Content-Disposition", "attachment;filename=" + fileName);
        byte[] buff = new byte[1024];
        BufferedInputStream bis = null;
        OutputStream os = null;
        try {
            os = res.getOutputStream();
            bis = new BufferedInputStream(new FileInputStream(outFile));
            int i = bis.read(buff);
            while (i != -1) {
                os.write(buff, 0, buff.length);
                os.flush();
                i = bis.read(buff);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (bis != null) {
                try {
                    bis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }


    }



    /**
     *
     *
     * @param req
     * @param res
     * @param
     * @return
     */
    @ApiIgnore
    @RequestMapping(value = "/download", method = RequestMethod.GET)
    public void download(HttpServletRequest req, HttpServletResponse res) throws APIException {

        String attachId = req.getParameter("attachId");

        ItenderAttach attach = null;

        if(!StringUtils.isEmpty(attachId)){

             attach = itenderReviewService.findAttachByAttachId(attachId);

            if(attach == null){
                throw new APIException(HttpStatus.BAD_REQUEST.value(), "100400", "文件不存在!");
            }
        }else{
            String referenceAttachId = req.getParameter("referenceAttachId");

             attach = itenderReviewService.findAttachByReferenceAttachId(referenceAttachId);

            if(attach == null){
                throw new APIException(HttpStatus.BAD_REQUEST.value(), "100400", "文件不存在!");
            }
        }


        httpHelper.download(res, req, attach.getName(), attach.getType());

        byte[] buff = new byte[1024];
        BufferedInputStream bis = null;
        OutputStream os = null;
        try {
            os = res.getOutputStream();
            bis = new BufferedInputStream(new FileInputStream(new File(getFileDirByName("attach_files")+File.separator+attach.getName())+"."+attach.getType()));
            int i = bis.read(buff);
            while (i != -1) {
                os.write(buff, 0, buff.length);
                os.flush();
                i = bis.read(buff);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (bis != null) {
                try {
                    bis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }

    /**
     * 上传附件
     *
     * @return
     * @throws APIException
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadFile(HttpServletRequest request,
                                          HttpServletResponse response) throws APIException {

        Map<String, Object> result = new HashMap<String, Object>();

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;


        String fileName = multipartRequest.getParameter("fileName");

        try{
            fileName  = URLDecoder.decode(fileName);
        }catch (Exception e){
            e.printStackTrace();
        }

        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

        Map<String, Object> resultSrc = new HashMap<String, Object>();


        String projectName = request.getContextPath();
        String outStr = "";
        // 文件保存目录路径
        String savePath = getFileDirByName("review_files");
        response.setContentType("text/html; charset=UTF-8");
        // 检查目录

        File dirFile = new File(savePath);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }
        // 此处是直接采用Spring的上传
        for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
            MultipartFile mf = entity.getValue();
            String fileFullname = fileName+".aip";

            File uploadFile = new File(savePath + File.separator + fileFullname);
            InputStream inputStream = null;
            FileOutputStream fileOutputStream = null;
            try {
                inputStream = mf.getInputStream();
                fileOutputStream = new FileOutputStream(uploadFile);
                IOUtils.copy(inputStream, fileOutputStream);
            } catch (Exception e) {
                result.put("code", -1001);
                result.put("msg", "上传失败");
                e.printStackTrace();
                return result;
            } finally {
                IOUtils.closeQuietly(inputStream);
                IOUtils.closeQuietly(fileOutputStream);
            }
        }
        result.put("code", 200);
        result.put("msg", "上传成功");
        result.put("data", resultSrc);
        return result;
        // 上传结束
    }

    @RequestMapping(value = "/getSignFile", method = RequestMethod.GET)
    public void getSignFile(HttpServletRequest request,HttpServletResponse res) throws Exception{

        InputStream inputStream =  new ClassPathResource("static/aip/用印登记表.docx").getInputStream();
       // File file = ResourceUtils.getFile("classpath:static/aip/用印登记表.docx");
        Map<String, String> datas = new HashMap<String, String>();

        String confirmId = request.getParameter("confirmId");

        ItenderConfirm itenderConfirm = itenderReviewService.findConfirmByConfirmId(confirmId);

        if(itenderConfirm == null){
            throw new Exception("confirm file not find");
        }
        File aipFile = new File(getFileDirByName("review_files")+File.separator+itenderConfirm.getName()+".aip");
        String fileName = null;
        File outFile = null;
        if(aipFile.exists()){
             fileName = aipFile.getName();
             outFile = aipFile;
        }else{
            //
            ItenderReview itenderReview = itenderReviewService.findById(itenderConfirm.getReviewId());
            if(itenderReview!=null)
                {
                    if(ReviewType.bid_winning.name().equals(itenderReview.getType())){

                        if(ReviewSignType.bid_winning.name().equals(itenderConfirm.getType()))
                        {
                            datas.put("${projectTitle}", "山西转型综合改革示范区管理委员建设管理部中标通知书用印登记表");
                        }else{
                            datas.put("${projectTitle}", "山西转型综合改革示范区管理委员建设管理部中标通知书（中标通知书附件）用印登记表");
                        }
                    }else{
                        if(ReviewSignType.tender_table.name().equals(itenderConfirm.getType()))
                        {
                            datas.put("${projectTitle}", "山西转型综合改革示范区管理委员建设管理部工程项目招标投标备案用印登记表");
                        }else{
                            datas.put("${projectTitle}", "山西转型综合改革示范区管理委员建设管理部招标文件用印登记表");
                        }
                    }


                }else{
                        if(ReviewSignType.tender_table.name().equals(itenderConfirm.getType()))
                        {
                            datas.put("${projectTitle}", "山西转型综合改革示范区管理委员建设管理部工程项目招标投标备案用印登记表");
                        }else{
                            datas.put("${projectTitle}", "山西转型综合改革示范区管理委员建设管理部招标文件用印登记表");
                        }
                }

            datas.put("${projectName}", itenderConfirm.getName());
            datas.put("${count}",itenderConfirm.getCount());
            String exportFile = getFileDirByName("review_files")+File.separator+itenderConfirm.getName()+".docx";
            boolean result = readwriteWord(inputStream,datas,exportFile);
            if(result){
                XWPFDocument document = new XWPFDocument(new FileInputStream(new File(exportFile)));

                PdfOptions options = PdfOptions.create();

                //中文字体处理
                options.fontProvider(new IFontProvider() {
                    public com.lowagie.text.Font getFont(String familyName, String encoding, float size, int style, Color color) {
                        try {
                            String path = getFileDirByName("review_files")+File.separator+ "fonts"+File.separator+"wei_yah.ttf";

                            com.lowagie.text.pdf.BaseFont bfChinese =
                                    com.lowagie.text.pdf.BaseFont.createFont(path, BaseFont.IDENTITY_H, BaseFont.EMBEDDED );
                            com.lowagie.text.Font fontChinese = new com.lowagie.text.Font(bfChinese);
                            if (familyName != null)
                                fontChinese.setFamily(familyName);
                            return fontChinese;
                        } catch (Exception e) {
                            e.printStackTrace();
                            return null;
                        }
                    }
                });
                //为输出文件创建目录
                //更改word内容并修改为pdf
                 fileName = itenderConfirm.getName()+".pdf";
                 outFile = new File(getFileDirByName("review_files")+fileName);
                outFile.getParentFile().mkdirs();
                PdfConverter.getInstance().convert(document, new FileOutputStream(outFile), options);


                document.close();


                //covert pdf.
        }


        }


        res.setHeader("content-type", "application/octet-stream");
        res.setContentType("application/octet-stream");
        res.setHeader("Content-Disposition", "attachment;filename=" + fileName);
        byte[] buff = new byte[1024];
        BufferedInputStream bis = null;
        OutputStream os = null;
        try {
            os = res.getOutputStream();
            bis = new BufferedInputStream(new FileInputStream(outFile));
            int i = bis.read(buff);
            while (i != -1) {
                os.write(buff, 0, buff.length);
                os.flush();
                i = bis.read(buff);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (bis != null) {
                try {
                    bis.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }


}


    /**
     * 实现对word读取和修改操作
     * @param map        待填充的数据，从数据库读取
     */
    public static boolean readwriteWord(InputStream sourceInputStream, Map<String,String> map, String exportFile){
        //读取word模板
//        String fileDir = new File(base.getFile(),"http://www.cnblogs.com/http://www.cnblogs.com/../doc/").getCanonicalPath();
        InputStream in = null;
        try {
            in = sourceInputStream;
        } catch (Exception e1) {
            e1.printStackTrace();
            return  false;
        }
        XWPFDocument document = null;
        try {
            document = new XWPFDocument(in);
        } catch (IOException e1) {
            e1.printStackTrace();
            return  false;
        }

        // 替换段落中的指定文字
        Iterator<XWPFParagraph> itPara = document.getParagraphsIterator();
        while (itPara.hasNext()) {
            XWPFParagraph paragraph = (XWPFParagraph) itPara.next();
            //String s = paragraph.getParagraphText();
            Set<String> set = map.keySet();
            Iterator<String> iterator = set.iterator();
            while (iterator.hasNext()) {
                String key = iterator.next();
                List<XWPFRun> run=paragraph.getRuns();
                for(int i=0;i<run.size();i++)
                {
                    int pos = run.get(i).getTextPosition();
                    String text = run.get(i).getText(pos);
                    if(text!=null && text.equals(key))
                    {
                        /**参数0表示生成的文字是要从哪一个地方开始放置,设置文字从位置0开始
                         * 就可以把原来的文字全部替换掉了
                         * */
                        run.get(i).setText(map.get(key),0);
                    }
                }
            }
        }

        // 替换表格中的指定文字
        Iterator<XWPFTable> itTable = document.getTablesIterator();
        while (itTable.hasNext()) {
            XWPFTable table = (XWPFTable) itTable.next();
            int rcount = table.getNumberOfRows();
            for (int i = 0; i < rcount; i++) {
                XWPFTableRow row = table.getRow(i);
                List<XWPFTableCell> cells = row.getTableCells();
                for (XWPFTableCell cell : cells) {
                    for (Map.Entry<String, String> e : map.entrySet()) {
                        if (cell.getText().equals(e.getKey())) {
                            cell.removeParagraph(0);
                           // cell.setText(e.getValue());
                            /**内容居中显示**/
                            XWPFParagraph newPara = new XWPFParagraph(cell.getCTTc().addNewP(), cell);
                            XWPFRun run=newPara.createRun();

                            /**内容居中显示**/
                            newPara.setAlignment(ParagraphAlignment.CENTER);

                            // run.getCTR().addNewRPr().addNewColor().setVal("FF0000");/**FF0000红色*/
                           // run.setUnderline(UnderlinePatterns.THICK);
                            run.setText(e.getValue());

                        }
                    }
                }
            }
        }


        //读取word文本内容

        ByteArrayOutputStream ostream = new ByteArrayOutputStream();

        FileOutputStream out = null;
        try {
            out = new FileOutputStream(exportFile,true);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return  false;
        }
        try {
            document.write(ostream);
        } catch (IOException e) {
            e.printStackTrace();
            return  false;
        }
        //输出字节流
        try {
            out.write(ostream.toByteArray());
        } catch (IOException e) {
            e.printStackTrace();
            return  false;
        }
        try {
            out.close();
        } catch (IOException e) {
            e.printStackTrace();
            return  false;
        }
        try {
            ostream.close();
        } catch (IOException e) {
            e.printStackTrace();
            return  false;
        }

        return  true;
    }

    String getFileDirByName(String name){
                String root = "C:\\\\";
                String os = System.getProperty("os.name").toLowerCase();
                if(isMacOS(os) || isMacOSX(os)){
                    root = "/Users/mac/Downloads";
                }else if (isLinux(os)){
                    root = "/root";
                }

                String filePath = root + File.separator+"data"+File.separator+name+File.separator;
                return  filePath;
            }

    @ApiOperation(value = "添加审批附件接口",notes = "用于新增审批信息")
    @RequestMapping(value = "/addReviewAttach",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addReviewAttach(HttpServletRequest request,ItenderReview review,@RequestParam("file") MultipartFile file) throws APIException{
        Map<String,Object> result = new HashMap<>();

        // 文件上传后的路径
        String filePath = getFileDirByName("review_files");
        // 解决中文问题，liunx下中文路径，图片显示问题
        // fileName = UUID.randomUUID() + suffixName;
        File dest = new File(filePath + file.getOriginalFilename());
        // 检测是否存在目录
        if (!dest.getParentFile().exists()) {
            boolean success =  dest.getParentFile().mkdirs();
        }
        try {
            file.transferTo(dest);

        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        //  review.setStatus(ReviewStatus.normal.name());
        review = itenderReviewService.add(review);
        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review);
        return ResponseEntity.ok(result);
    }



    @ApiOperation(value = "添加审批接口",notes = "用于新增审批信息,审批类型: tender (招标登记表，招标文件审批),notice_delay（公告变更）, notice_update（公告延期）,notice_cancel（再次公告）,notice_again（控制价&清单）,notice_price_verfiy（公告延期）,bid_winning（中标通知书）")
    @RequestMapping(value = "/addReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> addReview(HttpServletRequest request,
                                                        @RequestBody ItenderReview review) throws APIException{
        Map<String,Object> result = new HashMap<>();
        review.setCreateTime(new Date());
        review = itenderReviewService.add(review);
        if(!CommonUtility.isNonEmpty(review.getId())){
            result.put("status", false);
            result.put("msg", "添加审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review);
        return ResponseEntity.ok(result);
    }

    @ApiOperation(value = "删除审批接口",notes = "用于删除审批信息")
    @RequestMapping(value = "/delReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> delReview(HttpServletRequest request,
                                                           @ApiParam(name = "reviewId",value = "审批ID",required = true) @RequestParam(required = true) String reviewId
    ) throws APIException{
        Map<String,Object> result = new HashMap<>();
        logger.debug("==删除审批id=="+reviewId);
        int row = itenderReviewService.deleteById(reviewId);
        if(row == 0){
            result.put("status", false);
            result.put("msg", "删除审批失败！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }



    @ApiOperation(value = "更新签章份数接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateConfirmCount",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateSignResult(HttpServletRequest request,
                                                               @ApiParam(name = "confirmId",value = "confirmId",required = true) @RequestParam(required = true) String confirmId,
                                                               @ApiParam(name = "count",value = "count",required = true) @RequestParam(required = true) String count
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        ItenderConfirm itenderConfirm = new ItenderConfirm();
        itenderConfirm.setId(confirmId);
        itenderConfirm.setCount(count);
        itenderConfirm = itenderReviewService.updateConfrirm(itenderConfirm);
        if(itenderConfirm == null){
            result.put("status", false);
            result.put("msg", "跟新份数失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", itenderConfirm);
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "更新签章接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateSignResult",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateSignResult(HttpServletRequest request,
                                                               @ApiParam(name = "signId",value = "signId",required = true) @RequestParam(required = true) String signId,
                                                               @ApiParam(name = "description",value = "description",required = false) @RequestParam(required = false) String description,
                                                               @ApiParam(name = "confirmId",value = "confirmId",required = true) @RequestParam(required = true) String confirmId,
                                                               @ApiParam(name = "signResult",value = "signResult",required = true) @RequestParam(required = true) String signResult
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        if(signId == null || signId.equals("")){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
            return ResponseEntity.ok(result);
        }
        ItenderSign itenderSign = itenderReviewService.updateSignResult(confirmId,signId,signResult,description);
        if(itenderSign == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", itenderSign);
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "获取审批人列表",notes = "用于更新审批信息")
    @RequestMapping(value = "/getOperators",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> getOperators(HttpServletRequest request,
                                                                 @ApiParam(name = "operator",value = "operator",required = true) @RequestParam(required = true) String operator
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        List<ItenderUser> itenderUsers = itenderUserService.findByUserOperator(operator);

        if(itenderUsers == null){
            result.put("status", false);
            result.put("msg", "没有查询到相关人员！");
        }else{
            result.put("status", true);
        }
        result.put("data", itenderUsers);
        return ResponseEntity.ok(result);
    }



    @ApiOperation(value = "更新审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateReviewStatus",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateReviewStatus(HttpServletRequest request, @ApiParam(name = "id",value = "审批ID",required = true) @RequestParam(required = true) String id,
                                                                 @ApiParam(name = "assigneeId",value = "assigneeId",required = true) @RequestParam(required = true) String assigneeId,
                                                                 @ApiParam(name = "status",value = "status",required = true) @RequestParam(required = true) String status,
                                                                 @ApiParam(name = "remark",value = "remark",required = false) @RequestParam(required = false) String remark
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        ItenderReview reviewExsit = null;

        ItenderUser itenderUser = itenderUserService.findByUserId(assigneeId);

        if(itenderUser == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
            return ResponseEntity.ok(result);
        }

        reviewExsit = itenderReviewService.updateReviewStatus(id,assigneeId,itenderUser.getOperator(),status,remark);
        if(reviewExsit == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", reviewExsit);
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "退回审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/rollbackReviewStatus",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> rollbackReviewStatus(HttpServletRequest request, @ApiParam(name = "id",value = "审批ID",required = true) @RequestParam(required = true) String id
    ) throws APIException{

        Map<String,Object> result = new HashMap<>();
        ItenderReview reviewExsit = null;

        ItenderUser user = (ItenderUser)request.getSession().getAttribute("user");

        if(user == null){
            result.put("status", false);
            return ResponseEntity.ok(result);
        }


       int resultCode = itenderReviewService.rollbackReviewStatus(id,user.getId());
        if(resultCode != 0 ){
            result.put("status", false);
            result.put("msg", "回退审批失败！");
        }else{
            result.put("status", true);
        }
        return ResponseEntity.ok(result);
    }


    @ApiOperation(value = "更新审批接口",notes = "用于更新审批信息")
    @RequestMapping(value = "/updateReview",method = RequestMethod.POST)
    public ResponseEntity<Map<String,Object>> updateReview(HttpServletRequest request,@RequestBody ItenderReview review
    ) throws APIException{
        logger.debug("==审批信息=="+review.toString());
        Map<String,Object> result = new HashMap<>();
        ItenderReview reviewExsit = itenderReviewService.findById(review.getId());
        if(reviewExsit == null){
            result.put("status", false);
            result.put("msg", "未找到相关审批信息！");
            return ResponseEntity.ok(result);
        }


         review = itenderReviewService.updateReview(review);
        if(review == null){
            result.put("status", false);
            result.put("msg", "跟新审批失败！");
        }else{
            result.put("status", true);
        }
        result.put("data", review);
        return ResponseEntity.ok(result);
    }

}
