<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html>

<head>
    <tiles:insertAttribute name="head"/>
	 <style>
	    .modal-container {
	        position: fixed;
	        top: 0;
	        left: 0;
	        right: 0;
	        bottom: 0;
	        background: rgba(0, 0, 0, 0.5);
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        z-index: 1000;
	    }
	    .modal-email {
	        background: white;
	        padding: 20px;
	        border-radius: 8px;
	        text-align: center;
	    }
	    .popup-container {
	        position: fixed;
	        top: 0;
	        left: 0;
	        right: 0;
	        bottom: 0;
	        background: rgba(0, 0, 0, 0.5);
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        z-index: 1000;
	    }
	    .popup-content {
	        background: white;
	        padding: 40px;
	        border-radius: 8px;
	        text-align: center;
	        width: 400px;
	    }
	    .popup-close-btn {
	        margin-top: 15px;
	        padding: 10px 20px;
	        background-color: #007bff;
	        color: white;
	        border: none;
	        border-radius: 4px;
	        cursor: pointer;
	    }
	</style>

</head>
<body>
	<main class="sub_content" id="skipnav_target"> 
		<tiles:insertAttribute name="body" />                                                 
    </main>
    <footer>
        <tiles:insertAttribute name="footer" />
    </footer>
</body>
</html>
