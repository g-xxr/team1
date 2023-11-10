<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.multipart.*"%>
<%@ page import = "com.oreilly.servlet.*"%>
<%@ page import = "dao.*"%>
<%@ page import = "vo.*"%>
<%
	String uploadPath = request.getServletContext().getRealPath("/upload");
	// request 객체를 랩핑한 req(MultipartRequest타입)객체변수
	MultipartRequest req = new MultipartRequest(
		request, uploadPath, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
	
	// 수정해야할 목록
	// 이건 상품 테이블의 수정할 것들
	Goods g = new Goods();
	g.setGoodsNo(Integer.parseInt(req.getParameter("goodsNo")));
	g.setGoodsTitle(req.getParameter("goodsTitle"));
	g.setGoodsPrice(Integer.parseInt(req.getParameter("goodsPrice")));
	g.setSoldout(req.getParameter("soldout"));
	g.setGoodsMemo(req.getParameter("goodsMemo"));
	
	// 상품 이미지 테이블에서 수정해야 할 것들 
	// 수정 후 파일의 이름
	String updateName = req.getOriginalFileName("goodsImg");
	// 수정 후 파일의 저장 이름
	String name = req.getFilesystemName("goodsImg");
	// 수정 후 파일의 content type
	String contentType = req.getContentType("goodsImg");
	
	// goods dao불러오기 (goods, goodsImg)
	GoodsDao gd = new GoodsDao();
	String oldName = gd.getOldFilename(g.getGoodsNo());
	gd.updateGoods(g, updateName, name, contentType, oldName, uploadPath);
	
	response.sendRedirect(request.getContextPath()+"/goodsListManager.jsp?goodsNo="+g.getGoodsNo());
%>