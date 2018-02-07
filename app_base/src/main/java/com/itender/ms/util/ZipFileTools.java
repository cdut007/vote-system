package com.itender.ms.util;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

import java.io.*;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

public class ZipFileTools {
	/***
	 * 批量递归压缩
	 * 
	 * @param sources
	 * @param destinct
	 * @throws IOException
	 */
	public static void zip(List<File> sources, String destinct,String codec) throws IOException {
		ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(new File(destinct)));
		for (File file : sources) {
			zip(file, zos);
		}
		zos.setEncoding(codec);
		zos.close();
	}
	
	/***
	 * 批量递归压缩
	 * 
	 * @param sources
	 * @param destinct
	 * @throws IOException
	 */
	public static void zip(File[] sources, String destinct,String codec) throws IOException {
		ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(new File(destinct)));
		for (File file : sources) {
			zip(file, zos);
		}
		zos.setEncoding(codec);
		zos.close();
	}

	/***
	 * 单个递归压缩
	 * 
	 * @param source
	 * @param destinct
	 * @throws IOException
	 */
	public static void zip(File source, String destinct,String codec) throws IOException {
		ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(new File(destinct)));
		zos.setEncoding(codec);
		zip(source, zos);
		zos.close();
	}

	/***
	 * 单个递归压缩
	 * 
	 * @param source
	 * @param destinct
	 * @throws IOException
	 */
	public static void zip(InputStream inputStream, String entyrName, String destinct) throws IOException {
		ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(new File(destinct)));
		zos.setEncoding("gbk");
		zos.putNextEntry(new ZipEntry(entyrName));
		BufferedInputStream bis = new BufferedInputStream(inputStream);
		int length = -1;
		byte[] buffere = new byte[10 * 1024 * 1024];
		while ((length = bis.read(buffere)) != -1) {
			zos.write(buffere, 0, length);
		}
		zos.close();
	}

	/***
	 * 单个递归压缩
	 * 
	 * @param source
	 * @param destinct
	 * @throws IOException
	 */
	public static void zip(InputStream inputStream, String entyrName, OutputStream outputStream,String codec) throws IOException {
		ZipOutputStream zos = new ZipOutputStream(outputStream);
		zos.setEncoding(codec);
		zos.putNextEntry(new ZipEntry(entyrName));
		BufferedInputStream bis = new BufferedInputStream(inputStream);
		int length = -1;
		byte[] buffere = new byte[10 * 1024 * 1024];
		while ((length = bis.read(buffere)) != -1) {
			zos.write(buffere, 0, length);
		}
		zos.close();
	}

	private static void zip(File source, ZipOutputStream zos) throws IOException {
		List<File> fileList = loadFilename(source);
		byte[] buffere = new byte[10 * 1024 * 1024];
		for (int i = 0; i < fileList.size(); i++) {
			File file = (File) fileList.get(i);
			System.out.println(getEntryName(source.getCanonicalPath(), file));
			zos.putNextEntry(new ZipEntry(getEntryName(source.getCanonicalPath(), file)));
			BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
			int length = -1;
			while ((length = bis.read(buffere)) != -1) {
				zos.write(buffere, 0, length);
			}
			bis.close();
			zos.closeEntry();
		}
	}

	private static List<File> loadFilename(File file) {
		List<File> filenameList = new ArrayList<File>();
		if (file.isFile()) {
			filenameList.add(file);
		}
		if (file.isDirectory()) {
			for (File f : file.listFiles()) {
				filenameList.addAll(loadFilename(f));
			}
		}
		return filenameList;
	}

	private static String getEntryName(String base, File file) {
		File baseFile = new File(base);
		String filename = file.getPath();
		if (baseFile.getParentFile().getParentFile() == null) {
			return filename.substring(baseFile.getParent().length());
		}
		return filename.substring(baseFile.getParent().length() - 1);
	}

	/****
	 * unzip
	 * 
	 * @param zipFile
	 * @param destination
	 * @throws IOException
	 */
	public static void unzip(File zipFile, String destination) throws IOException {
		ZipFile zip = new ZipFile(zipFile);
		Enumeration<ZipEntry> en = zip.getEntries();
		ZipEntry entry = null;
		byte[] buffer = new byte[8192];
		int length = -1;
		InputStream input = null;
		BufferedOutputStream bos = null;
		File file = null;
		while (en.hasMoreElements()) {
			entry = en.nextElement();
			if (entry.isDirectory()) {
				System.out.println("directory");
				continue;
			}
			input = zip.getInputStream(entry);
			file = new File(destination, entry.getName());
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			bos = new BufferedOutputStream(new FileOutputStream(file));

			while (true) {
				length = input.read(buffer);
				if (length == -1)
					break;
				bos.write(buffer, 0, length);
			}
			bos.close();
			input.close();
		}
		zip.close();
	}

	public static void main(String[] args) throws IOException {
		unzip(new File("D:\\CABuildFile.zip"), "D:\\temp");
	}

}
