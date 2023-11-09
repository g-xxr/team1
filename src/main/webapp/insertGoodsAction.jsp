<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.*"%>
<%@ page import = "com.oreilly.servlet.multipart.*"%>
<%@ page import = "java.io.File"%>
<%@ page import = "dao.*"%>

<%	
	String uploadPath = request.getServletContext().getRealPath("/upload");
	// 업로드 경로, 파일 크기 등 지정하기
	MultipartRequest req = new MultipartRequest(
			request, uploadPath, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());

	/* 상품 이미지 정보 요청 유효성 검사*/
	// 상품 이미지 추가
	String contentType = req.getContentType("goodsImg");
	String filename = req.getFilesystemName("goodsImg"); // 저장된 파일 이름
	String originName = req.getOriginalFileName("goodsImg"); // 사진 추가했을때 이름
	
	if(!(contentType.equals("image/png") || contentType.equals("image/jpeg"))){
		// 이미 업로드 된 파일 삭제해야함
		File f = new File(uploadPath+"/"+filename); // 저장된 파일 위치에서 불러오기
		if(f.exists()){		// 파일이 존재한다면
			f.delete();		// 파일 삭제~
		}
		
		String msg = "UPLOAD IMAGE ONLY";
		response.sendRedirect(request.getContextPath()+"/insertGoodsForm.jsp?msg="+msg);
		return; 			
	}
	
	// 상품 추가 form
	String goodsTitle = req.getParameter("goodsTitle");
	int goodsPrice = Integer.parseInt(req.getParameter("goodsPrice"));
	String goodsMemo = req.getParameter("goodsMemo");
	
	
	// Dao 불러오기
	GoodsDao gd = new GoodsDao();
	gd.addGoods(goodsTitle, goodsPrice, goodsMemo, contentType, filename, originName);

	response.sendRedirect(request.getContextPath()+"/goodsListManager.jsp");
%>
