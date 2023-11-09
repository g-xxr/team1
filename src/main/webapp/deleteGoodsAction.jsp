<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.File"%>
<%@ page import = "dao.*"%>

<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	//Dao 불러오기
	GoodsDao gd = new GoodsDao();
	String filename = gd.deleteGoods(goodsNo);
	
	// 업로드 경로에 있는 이미지 파일 완전 삭제하기
	String path = request.getServletContext().getRealPath("/upload");
	File f = new File(path +"/"+filename);
	if(f.exists()){
		f.delete();
	}
	
	// 상품 삭제 후 페이지 돌아오기
	response.sendRedirect(request.getContextPath()+"/goodsListManager.jsp");
%>