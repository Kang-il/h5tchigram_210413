package com.h5tchigram.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {
	//1.실제 이미지가 저장될 경로
	public final static String FILE_UPLOAD_PATH="D:\\1\\06_Spring_Project\\quiz\\QuizProjectWorkSpace\\H5tchigram\\images/";
	
	public String saveFile(String userLoginId,MultipartFile file) throws IOException{
		//1.컴퓨터에 파일 업로드
		//2. 사용자마다 폴더를 따로 만들기
			//1.파일 디렉토리 경로 만듦(겹치지 않게) 예: marobiana_(시간)1620995857660/sun.png
		String directoryName=userLoginId+"_"+System.currentTimeMillis()+"/";
		String filePath=FILE_UPLOAD_PATH + directoryName;
		
		File directory=new File(filePath);
		if(directory.mkdir()==false) {//파일을 업로드할 filePath 경로에 폴더 생성을 한다.
			//실패시 
			return null;
		}
		
		//2. 파일 업로드 --> byte 단위로 업로드 한다.
		// throws IOException
		byte[] bytes=file.getBytes();
		//파일 패스 ::: marobiana_(시간)1620995857660/
		//파일 이름 ::: .getOriginalFileName() 업로드 하고자 했던(input에서 올린) 파일이름이 나온다.(확장자 포함)
		Path path=Paths.get(filePath+file.getOriginalFilename());
		// Files.write(업로드 경로,바이트로 변환된 파일) --- 이미지가 업로드됨.
		Files.write(path, bytes);
		
		
		//3. imageURL 만들기 및 반환하기
		return "/images/"+directoryName+file.getOriginalFilename();
	}
	
	
	public void deleteFile(String imagePath) throws IOException{
		Path path=Paths.get(FILE_UPLOAD_PATH+imagePath.replace("/images/", ""));
		
		//파일이 있으면 제거
		if(Files.exists(path)) {
			//제거
			Files.delete(path);
			
			//디렉토리 삭제
			path=path.getParent();
			if(Files.exists(path)) {
				Files.delete(path);
			}
		}
	}
	
}
