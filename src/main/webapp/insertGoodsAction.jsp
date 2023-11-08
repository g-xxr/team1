<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.*" %>
<%@ page import = "com.oreilly.servlet.multipart.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	// 세션 유효성 검사
	GoodsDao gd = new GoodsDao();
	Goods g = new Goods();
	GoodsImgDao gid = new GoodsImgDao();
	GoodsImg gi = new GoodsImg();
	
	String uploadPath = request.getServletContext().getRealPath("/upload");
	// 업로드 경로, 파일 크기 등 지정하기
	MultipartRequest req = new MultipartRequest(
			request, uploadPath, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());

	
	/* 상품 정보 요청 유효성 검사*/
	// 상품 추가
	String goodsTitle = req.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(req.getParameter("goodsPrice"));	// int 값으로 받았기 때문에 string으로 형변환 해줘야함
	String soldout = req.getParameter("soldout");
	String goodsMemo = req.getParameter("goodsMemo");
	
	// 디버깅 코드
	// System.out.println("goodsTitle: " + goodsTitle + "<br>"); 
	out.println("goodsTitle: " + goodsTitle);
	out.println("goodsPrice: " + goodsPrice);
	out.println("soldout: " + soldout);
	out.println("goodsMemo: " + goodsMemo);
	
	
	/* 상품 이미지 정보 요청 유효성 검사*/
	// 상품 이미지 추가
	String contentType = req.getContentType("goodsImg");
	String filename = req.getFilesystemName("goodsImg"); // 저장된 파일 이름
	String originName = req.getOriginalFileName("goodsImg");
	
%>
