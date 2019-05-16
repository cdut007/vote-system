package com.bank.guarantee.ms.service.impl;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import  com.bank.guarantee.ms.util.CommonUtility;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.bank.guarantee.common.utils.PageUtils;
import com.bank.guarantee.common.utils.Query;

import com.bank.guarantee.ms.dao.AttachDao;
import com.bank.guarantee.ms.entity.AttachEntity;
import com.bank.guarantee.ms.service.AttachService;
import org.springframework.util.StringUtils;

import javax.activation.MimetypesFileTypeMap;


@Service("attachService")
public class AttachServiceImpl extends ServiceImpl<AttachDao, AttachEntity> implements AttachService {


    private Logger logger = LoggerFactory.getLogger(AttachServiceImpl.class);

    @Autowired
    private AttachDao attachDao;

    /**
     * 获取文件扩展名
     *
     * @return
     */
    private String getExtension(String fileName) {
        File file = new File(fileName);
        String name = file.getName();
        return name.substring(name.lastIndexOf("."));
    }

    @Override
    public AttachEntity parse2Attachment(String fileName, InputStream inputStream) {
        AttachEntity attachment = new AttachEntity();
        attachment.setUploadTime(new Date());

        attachment.setId(UUID.randomUUID().toString());
        //文件名
        //去掉windows上传文件带有本地全路径
        int index = fileName.lastIndexOf("\\");
        if (index > 0) {
            fileName = fileName.substring(index + 1, fileName.length());
        }
        attachment.setFileName(fileName);

        //文件扩展名
        String extension = getExtension(fileName);
        attachment.setFileType(extension);
        String savePath = CommonUtility.getFileDirByName("guarantee_files") + File.separator + CommonUtility.generateUUID(true);

        File dirFile = new File(savePath);
        if (!dirFile.exists()) {
            dirFile.mkdirs();
        }

        FileOutputStream fileOutputStream = null;
        try {
            String newName = savePath + File.separator +fileName;
            File file = new File(newName);
            fileOutputStream = new FileOutputStream(file);
            IOUtils.copy(inputStream, fileOutputStream);

            attachment.setContentType(getContentType(file));
            attachment.setPath(file.getAbsolutePath());
            attachment.setLength(new BigDecimal(file.length()));
            return attachment;
        } catch (Exception e) {
            logger.error("", e);
            throw new RuntimeException(e);
        } finally {
            IOUtils.closeQuietly(inputStream);
            IOUtils.closeQuietly(fileOutputStream);
        }
    }

    private String getContentType(File file) {
        String contentType = null;
        try {
            Path path = Paths.get(file.getCanonicalPath());
            contentType = Files.probeContentType(path);
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
        if (contentType == null) {
            contentType = new MimetypesFileTypeMap().getContentType(file);
        }
        return contentType;
    }


    @Override
    public List<AttachEntity> findAttachByGroupId(String attachGroupId) {

        EntityWrapper<AttachEntity> attachsWarpper =  new EntityWrapper<AttachEntity>();
        attachsWarpper.eq("groupId",attachGroupId);
        List<String> columns = new ArrayList<>();
        columns.add("uploadTime");
        attachsWarpper.orderDesc(columns);
        return attachDao.selectList(attachsWarpper);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<AttachEntity> page = this.selectPage(
                new Query<AttachEntity>(params).getPage(),
                new EntityWrapper<AttachEntity>()
        );

        return new PageUtils(page);
    }

}
