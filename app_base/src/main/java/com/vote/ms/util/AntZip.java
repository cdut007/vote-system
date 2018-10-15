package com.vote.ms.util;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.util.Enumeration;

/**
 * 功能:zip压缩、解压(支持中文文件名)
 * 说明:本程序通过使用Apache Ant里提供的zip工具org.apache.tools.zip实现了zip压缩和解压功能.
 * 解决了由于java.util.zip包不支持汉字的问题。
 * 使用java.util.zip包时,当zip文件中有名字为中文的文件时,
 * 就会出现异常:"Exception  in thread "main " java.lang.IllegalArgumentException
 * at   java.util.zip.ZipInputStream.getUTF8String(ZipInputStream.java:285)
 * 注意:
 * 1、使用时把ant.jar放到classpath中,程序中使用import org.apache.tools.zip.*;
 * 2、Apache Ant 下载地址:http://ant.apache.org/
 * 3、Ant ZIP API:http://www.jajakarta.org/ant/ant-1.6.1/docs/mix/manual/api/org/apache/tools/zip/
 * 4、本程序使用Ant 1.7.1 中的ant.jar
 * <p>
 * 仅供编程学习参考.
 *
 * @author Winty
 * @date 2008-8-3
 * @Usage: 压缩:java AntZip -zip "directoryName"
 * 解压:java AntZip -unzip "fileName.zip"
 */

public class AntZip {
    private Logger logger = LoggerFactory.getLogger(AntZip.class);

    private ZipFile zipFile;
    private ZipOutputStream zipOut;     //压缩Zip
    private ZipEntry zipEntry;
    private static int bufSize;    //size of bytes
    private byte[] buf;
    private int readedBytes;

    public AntZip() {
        this(512);
    }

    public AntZip(int bufSize) {
        this.bufSize = bufSize;
        this.buf = new byte[this.bufSize];
    }

    //压缩文件夹内的文件
    public File doZip(String zipDirectory) {//zipDirectoryPath:需要压缩的文件夹名
        File file;
        File zipDir;

        zipDir = new File(zipDirectory);
        String zipFileName = zipDirectory + ".zip";//压缩后生成的zip文件名
        File zipFile = null;
        try {
            zipFile = new File(zipFileName);
            this.zipOut = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(zipFile)));
            handleDir(zipDir, this.zipOut);
            this.zipOut.close();
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
            ;
        }

        return zipFile;
    }

    //由doZip调用,递归完成目录文件读取
    private void handleDir(File dir, ZipOutputStream zipOut) throws IOException {
        FileInputStream fileIn;
        File[] files;

        files = dir.listFiles();

        if (files.length == 0) {//如果目录为空,则单独创建之.
            //ZipEntry的isDirectory()方法中,目录以"/"结尾.
            this.zipOut.putNextEntry(new ZipEntry(dir.toString() + "/"));
            this.zipOut.closeEntry();
        } else {//如果目录不为空,则分别处理目录和文件.
            for (File fileName : files) {
                //System.out.println(fileName);
                if (fileName.isDirectory()) {
                    handleDir(fileName, this.zipOut);
                } else {
                    fileIn = new FileInputStream(fileName);
//                    this.zipOut.putNextEntry(new ZipEntry(dir.getName() + File.separator + fileName.getName()));
                    this.zipOut.putNextEntry(new ZipEntry(fileName.getName()));

                    while ((this.readedBytes = fileIn.read(this.buf)) > 0) {
                        this.zipOut.write(this.buf, 0, this.readedBytes);
                    }
                    this.zipOut.closeEntry();
                }
            }
        }
    }

    /**
     * 解压指定zip文件
     *
     * @param unZipfileName 要解压zip文件全路劲名称
     * @param toFilePath    解压到的目录
     */
    public void unZip(String unZipfileName, String toFilePath) {
        FileOutputStream fileOut;
        File file;
        InputStream inputStream;

        try {
            this.zipFile = new ZipFile(unZipfileName, "gbk");
            for (Enumeration entries = this.zipFile.getEntries(); entries.hasMoreElements(); ) {
                ZipEntry entry = (ZipEntry) entries.nextElement();
                file = new File(toFilePath + File.separator + entry.getName());
                if (entry.isDirectory()) {
                    file.mkdirs();
                } else {
                    //如果指定文件的目录不存在,则创建之.
                    File parent = file.getParentFile();
                    if (!parent.exists()) {
                        parent.mkdirs();
                    }

                    inputStream = zipFile.getInputStream(entry);

                    fileOut = new FileOutputStream(file);
                    while ((this.readedBytes = inputStream.read(this.buf)) > 0) {
                        fileOut.write(this.buf, 0, this.readedBytes);
                    }
                    fileOut.close();
                    inputStream.close();
                }
            }
            this.zipFile.close();
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
            ;
        }
    }

    //测试AntZip类
    public static void main(String[] args) throws Exception {
        String zipPath = "E:\\招投标\\解密验签投标文件\\投标文件加密.zip";
        AntZip zip = new AntZip();
        zip.unZip(zipPath, "");
        //      String str = FileUtils.readFileToString(new File("C:\\Users\\lbf\\Desktop\\testjiami\\test\\秘钥文件.txt"));
        //    System.out.println(str);

    }
}