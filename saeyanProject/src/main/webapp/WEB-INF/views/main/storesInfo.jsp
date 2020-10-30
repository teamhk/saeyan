
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="com.hk.saeyan.dto.StoreInfo"%>
<%@ page import="com.hk.saeyan.dto.Product"%>

<%@ page import="java.util.List"%>
<%
	List<Product> pro = (List<Product>) request.getAttribute("product");
%>
<%
	StoreInfo StoreInfo = (StoreInfo) request.getAttribute("storeInfo");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
<script src="http://code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
<title>퀴클린24셀프빨래방 | 카카오맵</title>
<script type="text/javascript">
//팝업창 오픈하여 데이터 전송
function openPopup( ) {

if($('#goodsTotAmt').val()==0){
	alert("품목을 선택해주세요")
	return false;
}

productForm.action=" info";

console.log("서브밋 들어옴");
var itemlist = "";
var itemname = $('input[name="item"]');
var itemmimi = $('input[name="mimi"]');
console.log(itemname);
console.log(itemmimi);
for(var i=0;i<itemname.length;i++){
	itemlist += itemname.eq(i).val()+"!@#"+itemmimi.eq(i).val()+"$%^";
}
console.log(itemlist);

console.log("서브밋 중반");
$('#items').val(itemlist);
console.log("서브밋 후반");
console.log($('#items').val(itemlist));

document.productForm.submit();

}


function wrapWindowByMask() {
	//화면의 높이와 너비를 구한다.
	var maskHeight = $(document).height();
	var maskWidth = $(window).width();
	//문서영역의 크기 
	console.log("document 사이즈:" + $(document).width() + "*"
			+ $(document).height());
	//브라우저에서 문서가 보여지는 영역의 크기
	console.log("window 사이즈:" + $(window).width() + "*"
			+ $(window).height());
	//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
	$('#mask').css({
		'width' : maskWidth,
		'height' : maskHeight
	});
	//애니메이션 효과
	//$('#mask').fadeIn(1000);      
	$('#mask').fadeTo("slow", 0.5);
}
function popupOpen() {
	$('.layerpop').css("position", "absolute");
	//영역 가운에데 레이어를 뛰우기 위해 위치 계산 
	$('.layerpop').css(
			"top",
			(($(window).height() - $('.layerpop').outerHeight()) / 2)
					+ $(window).scrollTop());
	$('.layerpop').css(
			"left",
			(($(window).width() - $('.layerpop').outerWidth()) / 2)
					+ $(window).scrollLeft());
	$('.layerpop').draggable();
	$('#layerbox').show();
}
function popupClose() {
	$('#layerbox').hide();
	$('#mask').hide();
	
	
}
function goDetail() {
	/*팝업 오픈전 별도의 작업이 있을경우 구현*/
	popupOpen(); //레이어 팝업창 오픈 
	wrapWindowByMask(); //화면 마스크 효과 
}
//장바구니팝업
function cartOpen(){
	popup();
	wrapWindowByMask();
}

function popup(){
	$('#cartpop').css("position", "absolute");
	//영역 가운에데 레이어를 뛰우기 위해 위치 계산 
	$('#cartpop').css(
			"top",
			(($(window).height() - $('#cartpop').outerHeight()) / 2)
					+ $(window).scrollTop());
	$('#cartpop').css(
			"left",
			(($(window).width() - $('#cartpop').outerWidth()) / 2)
					+ $(window).scrollLeft());
	$('#cartpop').draggable();
	$("#cartpop").show();
}

$(document).ready(function() {
	//페이지 들어왔을떄 즐겨찾기 여부 확인하여 표시
	var like1 = "${loginMember.likeStore1}";
	var like2 = "${loginMember.likeStore2}";
	var like3 = "${loginMember.likeStore3}";
	
	if(like1==${storeInfo.snum} || like2==${storeInfo.snum} || like3==${storeInfo.snum}){
		$(".ico_bookmark").css("background-position","-120px -480px");
	}
	


	//장바구니담기
	var cartform= $("form[name='productForm']");
	$(".ordercart").on("click",function(){
		var itemlist = "";
		var itemname = $('input[name="item"]');
		var itemmimi = $('input[name="mimi"]');
		for(var i=0;i<itemname.length;i++){
			itemlist += itemname.eq(i).val()+"!@#"+itemmimi.eq(i).val()+"$%^";

		}
		$('#items').val(itemlist);
		cartform.submit();	

		
	});

	var formObj = $("form[name='writeForms']");
	$(".write_btn").on("click", function() {
		if (fn_valiChk()) {
			return false;
		}
		alert("문의글 작성이 완료되었습니다.");
		formObj.attr("action", "/");
		formObj.attr("method", "post");
		formObj.submit();
	});
	$(".link_bookmark").on("click", function(){
		var id = '${loginMember.id}'
		if(id==""){
			alert("로그인 해주세요");
			return false;
		}
		var snum = ${storeInfo.snum}
		console.log("id는", id);
		console.log("snum은", snum);
		$.ajax({
			url: "/likeStore",
			dataType:"json",
			method: "post",
			data:{
				id:id,
				snum:snum
				},
			success : function(data){
				if(data==0){
					alert("관심점포에 등록되었습니다.");
					$(".ico_bookmark").css("background-position","-120px -480px");
				} else if (data==1){
					alert("관심점포가 해제되었습니다.");
					$(".ico_bookmark").css("background-position","-100px -480px");
				} else {
					alert ("관심점포는 최대 3개까지만 등록 가능합니다.");
				}
			},
			error:function(error){
				alert("에러가 발생했습니다.");
				console.log("error:",error);
			}
			
		});
	});
	
})
	function fn_valiChk() {
		var writeForm = $("form[name='writeForm'] .chk").length;
		for (var i = 0; i < writeForm; i++) {
			if ($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null) {
				alert($(".chk").eq(i).attr("title"));
				return true;
			}
		}
	}
</script>
<link
	href="//t1.daumcdn.net/localimg/localimages/07/common/kakaomap_favicon.ico"
	rel="shortcut icon">


<link rel="stylesheet" type="text/css"
	href="//t1.daumcdn.net/kakaomapweb/place/jscss/pc.efe78505.css">


<style type="text/css">/* global */
.screen_out {
	overflow: hidden;
	position: absolute;
	width: 0;
	height: 0;
	line-height: 0;
	text-indent: -9999px
}
.show {
	display: block
}
.hide {
	display: none
}
/* PC Social Share */
/* 2018-04-25 수정 시작 */
.social_comm_p {
	position: absolute;
	z-index: 1000;
}
.social_comm_p .img_social {
	display: block;
	overflow: hidden;
	font-size: 0;
	background:
		url(//t1.daumcdn.net/daumtop_deco/images/common/social/img_social_200414.png)
		no-repeat 0 0;
	text-indent: -9999px
}
.social_comm_p .sns_comm_p {
	overflow: hidden;
	position: relative;
	border: 1px solid #e2e2e2;
	font-size: 11px;
	color: #222;
	background-color: #fff;
	letter-spacing: -0.025em
}
.social_comm_p .btn_close {
	position: absolute;
	top: 5px;
	right: 5px;
	width: 24px;
	height: 24px
}
.social_comm_p .ico_close {
	width: 15px;
	height: 16px;
	margin: 5px;
	background-position: -150px 0
}
.social_comm_p .share_layer {
	position: relative;
	width: 260px;
	min-height: 228px
}
.social_comm_p .list_sns {
	overflow: hidden;
	margin: 26px 14px 0일단 바
}
.social_comm_p .list_sns li {
	float: left;
	width: 77px;
	height: 78px
}
.social_comm_p .list_sns .link_sns {
	display: block;
	text-align: center;
	text-decoration: none
}
.social_comm_p .list_sns .link_sns .img_social {
	width: 43px;
	height: 43px;
	margin: 0 auto 4px
}
.social_comm_p .list_sns .tit_sns {
	display: block;
	margin-top: 7px;
	font-weight: normal;
	line-height: 16px
}
.social_comm_p .list_sns .ico_sns_ks {
	background-position: -50px 0
}
.social_comm_p .list_sns .ico_sns_fb {
	background-position: -100px 0
}
.social_comm_p .list_sns .ico_sns_tw {
	background-position: 0 -50px
}
.social_comm_p .list_sns .ico_sns_cafe {
	background-position: -100px -50px
}
.social_comm_p .list_sns .ico_sns_mail {
	background-position: -50px -50px
}
.social_comm_p .list_sns .ico_sns_kt {
	background-position: 0 0
}
.social_comm_p .sns_copyurl {
	margin: -1px 26px 0;
	padding-bottom: 23px
}
.social_comm_p .sns_copyurl .link_copyurl {
	display: block;
	overflow: hidden;
	position: relative;
	height: 23px;
	line-height: 23px;
	border: 1px solid #d0d0d0;
	background-color: #f8f8f8;
	text-decoration: none
}
.social_comm_p .sns_copyurl .txt_url {
	display: block;
	overflow: hidden;
	padding: 0 64px 0 7px;
	color: #2695f8;
	white-space: nowrap;
	text-overflow: ellipsis
}
.social_comm_p .sns_copyurl .txt_copy {
	position: absolute;
	top: 0;
	right: 0;
	width: 47px;
	height: 25px;
	border-left: 1px solid #d0d0d0;
	background-color: #fff;
	text-align: center
}
.social_comm_p .copyurl_layer {
	width: 254px;
	height: 78px;
	text-align: center
}
.social_comm_p .inner_copyurl {
	display: table;
	width: 100%;
	height: 100%
}
.social_comm_p .inner_copyurl .desc_copyurl {
	display: table-cell;
	padding: 18px 0 17px;
	line-height: 19px;
	vertical-align: middle
}
.social_comm_p .sns_copyurl_type2 .tf_url {
	display: block;
	width: 210px;
	height: 25px;
	padding: 0 10px;
	border: 0 none;
	color: #2695f8;
	background-color: transparent
}
.social_comm_p .sns_copyurl_type2 .desc_tip {
	padding: 13px 0;
	line-height: 18px;
	color: #888;
	text-align: center;
	letter-spacing: 0
}
@media only screen and (-webkit-min-device-pixel-ratio: 1.5) , only screen and
		(min-device-pixel-ratio: 1.5) , only screen and (min-resolution:
		144dpi) , only screen and (min-resolution: 1.5dppx) {
	.social_comm_p .img_social {
		background-image:
			url(//t1.daumcdn.net/daumtop_deco/images/common/social/rtn/img_social_200414.png);
		background-size: 170px 100px
	}
}
/*-- POPUP common style S ======================================================================================================================== --*/
#mask {
	position: absolute;
	left: 0;
	top: 0;
	z-index: 999;
	background-color: #000000;
	display: none;
}
.layerpop {
	display: none;
	z-index: 1000;
	border: 2px solid #ccc;
	background: #fff;
	/* 	cursor: move; */
}
.layerpop_area .title {
	padding: 10px 10px 10px 10px;
	border: 0px solid #aaaaaa;
	background: #f1f1f1;
	color: red;
	font-size: 1.3em;
	font-weight: bold;
	line-height: 24px;
}
.layerpop_area .layerpop_close {
	width: 25px;
	height: 25px;
	display: block;
	position: absolute;
	top: 10px;
	right: 10px;
	background: transparent url('/resources/images/btn_exit_off.png') no-repeat;
}
}
.layerpop_area .layerpop_close:hover {
	background: transparent url('/resources/images/btn_exit_on.png') no-repeat;
	cursor: pointer;
}
}
.layerpop_area .content {
	width: 96%;
	margin: 2%;
	color: #828282;
}
.starcolor {
	color: red;
}
</style>




</head>

<body>
	<div id="kakaoIndex">
		<a href="#kakaoBody">본문 바로가기</a> <a href="#kakaoGnb">메뉴 바로가기</a>
	</div>
	<div id="kakaoWrap" class="wrap_mapdetail">
		<div data-viewid="header" id="kakaoHead" class="head_mapdetail"
			role="banner">

			<h1 class="logo_daum">
				<a href="http://daum.net" id="kakaoLogo" data-logtarget
					data-logevent="daum_top" target="_blank"><img
					src="//t1.daumcdn.net/localimg/localimages/07/2017/pc/rtn/logo_daum.png"
					width="44" height="18" class="img_logo" alt="다음"></a> <a
					href="https://map.kakao.com" id="kakaoServiceLogo" data-logtarget
					data-logevent="map_top" target="_blank"> <img
					src="//t1.daumcdn.net/localimg/localimages/07/2017/pc/rtn/logo_service.png"
					width="39" height="20" class="img_logo" alt="지도">
				</a>
			</h1>

			<h1 class="logo_daum">
				2018-07-23 수정 <a href="https://map.kakao.com" id="#kakaoMapLogo"
					data-logtarget="" data-logevent="map_top" target="_blank"><img
					src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/logo_kakaomap.png"
					width="121" height="25" class="img_logo" alt="카카오맵"
					id="exifviewer-img-1" exifid="1656209132"
					oldsrc="http://t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/logo_kakaomap.png">
				</a>
			</h1>
			<div data-viewid="header" data-root="" class="search_map">
				<h2 class="screen_out">검색</h2>
				<form id="searchForm" name="searchForm" method="GET">
					<fieldset>
						<legend class="screen_out">검색어 입력 폼</legend>
						<label for="searchKeyword" class="lab_search">카카오맵 지도 검색</label> <input
							type="text" name="q" id="searchKeyword" class="tf_search"
							autocomplete="off" spellcheck="false">
						<button type="submit" id="kakaoBtnSearch" class="btn_search">
							<span class="ico_comm ico_search">검색</span>
						</button>
					</fieldset>
					<blockquote id="searchKeywordSuggest" class="wrapper">
						<div class="suggestBox box_sub" style="display: none;">
							<div class="baseBox bg">
								<div class="list">
									<ul class="suggest_list_target"></ul>
								</div>
							</div>
							<div class="favorite_find"></div>
							<div class="search_recent"></div>
						</div>
						<div class="suggestBox box_sub">
							<div class="baseBox bg">
								<div class="list">
									<ul class="suggest_list_target"></ul>
								</div>
							</div>
							<div class="favorite_find"></div>
							<div class="search_recent"></div>
						</div>
					</blockquote>
				</form>
			</div>

			<div id="kakaoGnb" data-viewid="navBar" data-root=""
				class="location_bar" role="navigation">
				스크롤 내려 왔을 때 location_bar_on 추가
				<div class="inner_bar">
					<div class="outer_header_share_container">
						<div id="header_share_container"
							class="inner_header_share_container">
							<div class="social_comm_p hide">
								<div class="sns_comm_p share_layer">
									<strong class="screen_out">SNS로 공유하기 펼쳐짐</strong>
									<ul class="list_sns">
										<li><a href="#none" class="link_sns"
											data-handler="kakaotalk"> <span
												class="img_social ico_sns_kt"> </span>카카오톡
										</a></li>
										<li><a href="#none" class="link_sns"
											data-handler="kakaostory"> <span
												class="img_social ico_sns_ks"> </span>카카오스토리
										</a></li>
										<li><a href="#none" class="link_sns"
											data-handler="facebook"> <span
												class="img_social ico_sns_fb"> </span>페이스북
										</a></li>
										<li><a href="#none" class="link_sns"
											data-handler="twitter"> <span
												class="img_social ico_sns_tw"> </span>트위터
										</a></li>
										<li><a href="#none" class="link_sns" data-handler="mail">
												<span class="img_social ico_sns_mail"> </span>다음메일
										</a></li>
										<li><a href="#none" class="link_sns"
											data-handler="daumcafe"> <span
												class="img_social ico_sns_cafe"> </span>다음카페
										</a></li>
									</ul>
									<div class="copyUrl">
										<div class="sns_copyurl">
											<a href="#none" class="link_copyurl"> <span
												class="screen_out">현재페이지 URL복사</span> <span class="txt_url">https://place.map.kakao.com/892584709</span>
												<span class="txt_copy">URL복사</span>
											</a>
										</div>
									</div>
									<button class="btn_close">
										<span class="img_social ico_close">공유목록 닫기</span>
									</button>
								</div>
								<div class="sns_comm_p copyurl_layer hide">
									<div class="inner_copyurl">
										<p class="desc_copyurl">
											주소가 복사되었습니다.<br>원하는곳에 붙여넣기(Ctrl+V)해주세요.
										</p>
										<button class="btn_close">
											<span class="img_social ico_close">공유목록 닫기</span>
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
					<h2 class="tit_location" aria-hidden="true" data-logtarget=""
						data-logevent="name_bar,name">퀴클린24셀프빨래방</h2>
					<strong class="screen_out">상세정보 퀵메뉴</strong>
					<ul class="list_lnb">
						<li><a
							href="https://map.kakao.com?urlX=483596&amp;urlY=1139090&amp;urlLevel=3&amp;itemId=892584709&amp;q=%ED%80%B4%ED%81%B4%EB%A6%B024%EC%85%80%ED%94%84%EB%B9%A8%EB%9E%98%EB%B0%A9&amp;srcid=892584709&amp;map_type=TYPE_MAP"
							target="_blank" class="link_lnb" data-logtarget=""
							data-logevent="name_bar,map"> <span class="ico_comm ico_map">지도</span>
								2018-11-28 추가 : 텍스트 감싸는 .ico_comm.ico_map 요소 추가
						</a></li> 2018-11-28 추가 : 로드뷰, 즐겨찾기 위치이동으로 인한 추가
						<li><a
							href="https://map.kakao.com?srcid=892584709&amp;confirmid=892584709&amp;q=%ED%80%B4%ED%81%B4%EB%A6%B024%EC%85%80%ED%94%84%EB%B9%A8%EB%9E%98%EB%B0%A9&amp;rv=on"
							target="_blank" class="link_lnb" data-roadview=""
							data-logtarget="" data-logevent="name_bar,roadview"> <span
								class="ico_comm ico_roadview">로드뷰</span> 2018-11-28 추가 : 텍스트 감싸는
								.ico_comm.ico_roadview 요소 추가
						</a></li>
						<li>2018-11-28 즐겨찾기 메뉴의 lst클래스 삭제 <a href="#none"
							class="link_lnb link_bookmark " data-fid="" data-link="fav"
							data-logtarget="" data-logevent="name_bar,favorite"> <span
								class="ico_comm ico_bookmark">즐겨찾기 추가</span> <span
								class="ico_num ico_num"><span class="screen_out">나의
										즐겨찾기 폴더 개수</span></span>
						</a>
						</li>
						<li data-share=""><a href="#none" target="_blank"
							class="link_lnb" data-link="share"> <span
								class="ico_comm ico_share">공유하기</span>
						</a></li> // 2018-11-28 추가 : 공유하기 버튼 추가
						<li><a
							href="https://map.kakao.com?map_type=TYPE_MAP&amp;target=car&amp;rt=,,483596,1139090&amp;rt1=&amp;rt2=%ED%80%B4%ED%81%B4%EB%A6%B024%EC%85%80%ED%94%84%EB%B9%A8%EB%9E%98%EB%B0%A9&amp;rtIds=,892584709"
							target="_blank" class="link_lnb" data-logtarget=""
							data-logevent="name_bar,route"> <span
								class="ico_comm ico_route">길찾기</span> 2018-11-28 추가 : 텍스트 감싸는
								.ico_comm.ico_route 요소 추가
						</a></li>
					</ul>
				</div>
			</div>
			<div data-viewid="headerProfile" data-root="">
				<a href="https://map.kakao.com/user/signup" target="_top"
					class="btn_login">시작하기</a>
			</div>

		</div>
		<hr class="hide">
		<div data-viewid="nativeAdvertisement"
			adfit-unit-id="DAN-1h8210bp60zzq" data-root=""
			style="position: absolute; top: 354px; left: 50%; margin-left: -555px;"
			adfit-init="true" adfit-unit-idx="0">
			<strong
				style="overflow: hidden; position: absolute; width: 0; height: 0; line-height: 0; text-indent: -9999px">광고</strong>
			<a
				href="https://analytics.ad.daum.net/clk?wa=kYrDZmAs_17qld0MtxcOTw&amp;enc=ZpRCYkW-dpMXSnvMo4DsErYV17s_vfccVRVMfJL6IgC3j_TT7-tcnNSzi7bYsgg5SimxpP2PQY2bjNLrJNC12nCBNR0Z2Eqc1f3lBSyWj9Usw6tT7BSNzqjh5DUZudILd_VpJtv_NSbwzVV47yV3QVblWKD017_2TiW9lNRziZXjpbHoTt6oYGLW65TTpUf5dAWeXiMjbe9RcsG_dBH8EkK_6_O0qhDpsJQul1RcreM8XZ74MscbFzFQPCpnrqoc7L0DYCStMGjhnZVAMMMXcRUnvQi7i53kpcNZ3fnymceY3I-fJwXZT35A3IZJBzamA-FQjF1qrugLbakRV1s17PjElbzWG69pzlwQ6VtmpdUgt9gDnpIuSuYhdOQLsSI4is5lujWv2_1L5ag9SkQ38rSQILaGyv34ewtFLSsuBCEqFOpjYBgZWU6a3BllPI3zbE7LaWKJFEskkd9IkXG7EEKvhKxGjHvYR2Eznw0lfku0-qbBlMsBKqu01yqGva3rn8pJrOqMTIPd1RLxQx5SvbS3iGZX5sLWpNNbRfQt_i0lNbwIWt2PIqTPawzfkuzBteQEALpLgO_GFSvNGl2mQhpjpwjGOKMtG7RQs234uT7csY_baLIdF0Oqk2svdgj9aFg8RI--ZMJjKTjGGqJcT6N9mb4qEqvFwU-kA_mic5ZA0dQtnVVwM9PAFfavBK2Z&amp;lc=1"
				target="_blank" style="display: block" adfit-landing-url=""> <span
				style="display: block; overflow: hidden; position: relative">
					<img width="125" height="94" adfit-image-width="125"
					adfit-image-height="94" adfit-main-img-url=""
					style="display: block; border-radius: 4px"
					alt="암 투병 하며 쌍둥이를 돌보는 엄마"
					src="https://img1.daumcdn.net/thumb/S250x187/?scode=b2_01&amp;x-twg-thumb-fname=http%3A%2F%2Ft1.daumcdn.net%2Fb2%2Fcreative%2F51957%2Fa72797fc8570cdb8e75138ccf48ad592.jpg&amp;TWGServiceId=b2&amp;Expires=1601816400&amp;Signature=zy4LOEmuej96Tys0Wyd7QqYPBLY%3D"
					adfit-action-type="mainImage"> <img adfit-ad-info-icon=""
					src="https://t1.daumcdn.net/b2/templates/image/opt_out_30.png"
					width="24" height="16"
					style="position: absolute; top: 4px; right: 4px; cursor: pointer; pointer-events: auto;"
					alt="암 투병 하며 쌍둥이를 돌보는 엄마" adfit-action-type="adInfoIcon">
			</span> <strong class="tit_item" adfit-title=""
				style="display: block; overflow: hidden; width: 125px; max-height: 38px; padding-top: 6px; font-weight: normal; font-size: 13px; line-height: 18px; color: #555; font-family: AppleSDGothicNeo-Regular, 'Malgun Gothic', '맑은 고딕', dotum, '돋움', sans-serif; text-align: center"
				adfit-action-type="title">암 투병 하며 쌍둥이를 돌보는 엄마</strong>
			</a>
		</div>
		<div id="kakaoContent" role="main" class="cont_mapdetail">
			<div class="dimmed_layer hide"></div>
			<div id="mArticle">
				<div data-viewid="basicInfo" class="cont_essential">
					<div data-viewid="basicInfoTop" data-root="">
						<div class="details_present" style="background: none;">
							<a href="#none" class="link_present" data-logtarget=""
								data-logevent="info_pannel,main_pic"> <span
								class="bg_present"
								style="background-image: url('//img1.daumcdn.net/thumb/T800x0.q70/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flocalfiy%2F2D6916B41D7C492EB7A93CEFC2F357AA')"></span>
								<span class="frame_g"></span>
							</a>
						</div>
						<div class="place_details">
							<div class="inner_place">
								<span class="color_g txt_elocation">${storeInfo.sname}</span>
								<h2 class="tit_location">${storeInfo.sname}</h2>
								<div class="location_evaluation">
									<span class="txt_location"><span class="screen_out">분류:
									</span>셀프빨래방</span> <span class="ico_comm ico_dot"></span> <a href="#none"
										class="link_evaluation" data-cnt="3" data-target="comment"
										data-logtarget="" data-logevent="info_pannel,point">평점 <span
										class="color_b">5.0<span class="screen_out">점</span></span> <span
										class="color_g">(3)<span class="screen_out">명 평가</span></span>
									</a> <span class="ico_comm ico_dot"></span> <a href="#none"
										class="link_evaluation" data-cnt="0" data-target="review"
										data-logtarget="" data-logevent="info_pannel,review"> 리뷰 <span
										class="color_b inactive">0<span class="screen_out">개</span></span>
									</a>
								</div>
								<strong class="screen_out">위치 정보 및 공유하기</strong>
								<ul class="list_place">
									<li><a
										href="https://map.kakao.com?urlX=483596&amp;urlY=1139090&amp;urlLevel=3&amp;itemId=892584709&amp;q=%ED%80%B4%ED%81%B4%EB%A6%B024%EC%85%80%ED%94%84%EB%B9%A8%EB%9E%98%EB%B0%A9&amp;srcid=892584709&amp;map_type=TYPE_MAP"
										target="_blank" class="link_place" data-logtarget=""
										data-logevent="info_pannel,map_view"><span
											class="ico_comm ico_storemap"></span>지도</a></li>
									<li><a
										href="https://map.kakao.com?map_type=TYPE_MAP&amp;target=car&amp;rt=,,483596,1139090&amp;rt1=&amp;rt2=%ED%80%B4%ED%81%B4%EB%A6%B024%EC%85%80%ED%94%84%EB%B9%A8%EB%9E%98%EB%B0%A9&amp;rtIds=,892584709"
										target="_blank" class="link_place" data-logtarget=""
										data-logevent="info_pannel,route"><span
											class="ico_comm ico_route"></span>길찾기</a></li>
									<li><a
										href="https://map.kakao.com?srcid=892584709&amp;confirmid=892584709&amp;q=%ED%80%B4%ED%81%B4%EB%A6%B024%EC%85%80%ED%94%84%EB%B9%A8%EB%9E%98%EB%B0%A9&amp;rv=on"
										class="link_place" target="_blank" data-logtarget=""
										data-logevent="info_pannel,roadview" data-roadview=""><span
											class="ico_comm ico_roadmap"></span>로드뷰</a></li>
									<li class="lst"><a href="#none" class="link_place"
										data-logevent="info_pannel,share"><span
											class="ico_comm ico_share"></span>공유하기</a>
										<div data-viewid="snsShare" data-root="" class="detail_share">
										</div>
										<div class="place_share_container" id="place_share_container">
											<div class="social_comm_p hide">
												<div class="sns_comm_p share_layer">
													<strong class="screen_out">SNS로 공유하기 펼쳐짐</strong>
													<ul class="list_sns">
														<li><a href="#none" class="link_sns"
															data-handler="kakaotalk"> <span
																class="img_social ico_sns_kt"> </span>카카오톡
														</a></li>
														<li><a href="#none" class="link_sns"
															data-handler="kakaostory"> <span
																class="img_social ico_sns_ks"> </span>카카오스토리
														</a></li>
														<li><a href="#none" class="link_sns"
															data-handler="facebook"> <span
																class="img_social ico_sns_fb"> </span>페이스북
														</a></li>
														<li><a href="#none" class="link_sns"
															data-handler="twitter"> <span
																class="img_social ico_sns_tw"> </span>트위터
														</a></li>
														<li><a href="#none" class="link_sns"
															data-handler="mail"> <span
																class="img_social ico_sns_mail"> </span>다음메일
														</a></li>
														<li><a href="#none" class="link_sns"
															data-handler="daumcafe"> <span
																class="img_social ico_sns_cafe"> </span>다음카페
														</a></li>
													</ul>
													<div class="copyUrl">
														<div class="sns_copyurl">
															<a href="#none" class="link_copyurl"> <span
																class="screen_out">현재페이지 URL복사</span> <span
																class="txt_url">https://place.map.kakao.com/892584709</span>
																<span class="txt_copy">URL복사</span>
															</a>
														</div>
													</div>
													<button class="btn_close">
														<span class="img_social ico_close">공유목록 닫기</span>
													</button>
												</div>
												<div class="sns_comm_p copyurl_layer hide">
													<div class="inner_copyurl">
														<p class="desc_copyurl">
															주소가 복사되었습니다.<br>원하는곳에 붙여넣기(Ctrl+V)해주세요.
														</p>
														<button class="btn_close">
															<span class="img_social ico_close">공유목록 닫기</span>
														</button>
													</div>
												</div>
											</div>
										</div></li>
								</ul>

								<a href="#none" class="link_bookmark " data-fid=""
									data-logtarget="" data-logevent="info_pannel,favorite"> <span
									class="ico_comm ico_bookmark">즐겨찾기 추가</span> <span
									class="ico_num ico_num"><span class="screen_out">나의
											즐겨찾기 폴더 개수</span></span>
								</a>

							</div>
						</div>
						<div class="details_rest">
							<strong class="screen_out">기타 메뉴</strong>
							<ul class="list_rest">
								<li><a href="#none" class="link_rest" data-type="print"
									data-logtarget="" data-logevent="right_etc,print"> <span
										class="ico_comm ico_print">프린트하기</span>
								</a></li>
								<li><a href="#none" class="link_rest" data-type="roughmap"
									data-logtarget="" data-logevent="right_etc,simplemap"> <span
										class="ico_comm ico_makemap">약도 만들기</span>
								</a></li>
							</ul>
						</div>
					</div>
					<!-- 상세정보 -->
					<div data-viewid="basicInfo" data-root="" class="details_placeinfo">
						<h3 class="tit_subject">상세정보</h3>
						<div class="placeinfo_default">
							<h4 class="tit_detail">
								<span class="ico_comm ico_address">위치</span>
							</h4>
							<div class="location_detail">
								<span class="txt_address">${storeInfo.sname}</span> <span
									class="txt_addrnum">주소<span class="bg_bar"></span>
									${storeInfo.storeFirstAddr}&nbsp;${storeInfo.storeSecondAddr}
									
								</span>
							</div>
						</div>
						<div class="placeinfo_default">
							<h4 class="tit_detail">
								<span class="ico_comm ico_operation">운영시간 안내</span>
							</h4>
							<div class="location_detail openhour_wrap">
								<div class="location_present">
									<strong class="tit_operation fst">영업시간 <span
										class="open">영업중</span>
									</strong>

									<ul class="list_operation">
										<li><span class="txt_operation">매일 <span
												class="time_operation">00:00 ~ 24:00</span>

										</span></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="placeinfo_default placeinfo_facility">
							<h4 class="tit_facility">
								<span class="ico_comm ico_installation"></span>전화번호
								
							</h4>
							<ul class="list_facility">
								<li><span class="txt_operation">${storeInfo.scontact}</span>
								 
							</ul>
								</div>
							</div>
						</div>
						<div class="placeinfo_default placeinfo_facility">
							<h4 class="tit_facility">
								<span class="ico_comm ico_installation"></span>시설정보
							</h4>
							<ul class="list_facility">
								<li><span class="ico_comm ico_wifi"></span> <span
									class="color_g">WIFI</span></li>
								<li><span class="ico_comm ico_parking"></span> <span
									class="color_g">주차</span></li>
							</ul>



							<select id="selGoods" name="selGoods" style="height: 40px;">
								<option value=''>-[필수] 옵션을 선택해 주세요 -</option>
								<c:set var="num" value="1" />
								<c:forEach var="item" items="${items}" varStatus="status">
									<option id="${item}" value="${item}">${item}</option>
									<c:set var="num" value="${num + 1}" />
								</c:forEach>
							</select>


							<!-- </select> -->
								<form name='productForm' method="post" action="info">
								<div id="container" name="addCart">
									<input type="hidden" value="${storeInfo.snum}" name="snum">
									<input type="hidden" value="${storeInfo.sname}" name="sname">
									<input type="hidden" id="items" value="" name="items">
									<input type="hidden" value='N' name="choice"> <input
										type="hidden" value='N' name="c_check">

								</div>
							총금액:<input id="goodsTotAmt" name="pay_cart" value="0" readonly> 
							<input type='button' value='구매하기' onclick="javascript:openPopup()" /> 
								
						
							</form>
							<!-- //<input type='button' value='장바구니담기' onclick='location.href="cart"'/> -->
							<c:forEach var="ppp" items='${product }'>
								<input type='hidden' value='${ppp.pname}' name='pname'>
								<input type='hidden' value='${ppp.pprice}' name='pprice'>
							</c:forEach>
							
<script>
function Goods(){
	//json 배열[{goodsId:goodsId, goodsNm:goodsNm, amt:amt},{...},{...}]
	this.arrAllGoods = new Array();//상품 목록
	this.arrSelGoods = new Array();//선택한 상품 목록
	
var p = this;
	
	//상품 추가 시
this.select = function (trgtGoodsId){
	
	var selectedIndex = -1;//이미 추가했는지 0이면 추가할걸로 뜬다	
	
	//전체 목록 배열에서 검색하여 goodsId가 없다면 선택 목록에 push후 container안에 그려준다.
	
	//선택 목록에서 검색
for(var i=0;i<p.arrSelGoods.length;i++){
		
		if(p.arrSelGoods[i].goodsId==trgtGoodsId){
			selectedIndex = i;
			break;
		}
	}
	
	if(selectedIndex<0){//선택목록에 없을 경우 추가. 잇을경우 얼럿.
		//전체목록에서 선택 추가해줌.
		for(var j=0;j<p.arrAllGoods.length;j++){
			
			if(p.arrAllGoods[j].goodsId==trgtGoodsId){
				p.arrSelGoods.push(p.arrAllGoods[j]);
				p.arrSelGoods[p.arrSelGoods.length-1].cnt = 1;//무조건 개수 초기화
				p.appendChoiceDiv(p.arrAllGoods[j]);
				break;
			}
		}
	}else{
		alert("이미 추가한 상품입니다.");
	}
	p.afterProc();
}
//상품 제거 시
this.deselect = function (trgtGoodsId){
	
	var selectedIndex = -1;
	
	//배열에서 검색.
	for(var i=0;i<p.arrSelGoods.length;i++){
				
				if(p.arrSelGoods[i].goodsId==trgtGoodsId){
					p.removeChoiceDiv(p.arrSelGoods[i]);
					p.arrSelGoods.splice(i,1);
					break;
				}
			}
			p.afterProc();
		}
		
	this.appendChoiceDiv = function(prmtObj){
			var mimi="";
// 			if(prmtObj.goodsId==="셔츠"){
// 					mimi="Y1";
// 				}else if(prmtObj.goodsId==="블라우스"){
// 					mimi="B1";
// 				}else if(prmtObj.goodsId==="티셔츠"){
// 					mimi="T1";
// 				}else if(prmtObj.goodsId==="맨투맨"){
// 					mimi="M1";
// 				}else if(prmtObj.goodsId==="바지"){
// 					mimi="P1";
// 				}else if(prmtObj.goodsId==="니트"){
// 					mimi="K1";
// 				}else if(prmtObj.goodsId==="자켓"){
// 					mimi="J1";
// 				}else if(prmtObj.goodsId==="코트"){
// 					mimi="C1";
// 				}else if(prmtObj.goodsId==="패딩"){
// 					mimi="P2";
// 				}else if(prmtObj.goodsId==="이불"){
// 						mimi="D1";
// 				}else if(prmtObj.goodsId==="신발"){
// 					mimi="S1";
// 				}else if(prmtObj.goodsId==="커튼"){
// 					mimi="C2";
// 				}else if(prmtObj.goodsId==="가방"){
// 					mimi="B2";
// 				}
			
			
			var innerHtml = "";
			
			innerHtml += '<div id="div_'+prmtObj.goodsId+'">';			
			innerHtml += '<ul>';
			innerHtml += '	<li><input type="hidden" value='+prmtObj.goodsId+' name="item"/>'+prmtObj.goodsId+'</li>';
			innerHtml += '	<li>'+prmtObj.goodsprc+'원</li>';
			innerHtml += '	<li><button type="button" id="" class="add" name="" onclick="goods.minus(\''+prmtObj.goodsId+'\');">-</button></li>';
			innerHtml += '	<li><button type="button" id="" class="remove" name="" onclick="goods.plus(\''+prmtObj.goodsId+'\');">+</button></li>';
			innerHtml += '	<li>개수:<input type="text" id="input_cnt_'+prmtObj.goodsId+'" name="mimi" value="0" readonly/>'
			innerHtml += '	<li>가격:<input type="text" id="input_sumAmt_'+prmtObj.goodsId+'" name="" value="0" readonly/>'
			innerHtml += '	<li><button type="button" id="" class="remove" name="" onclick="goods.deselect(\''+prmtObj.goodsId+'\');">제거</button></li>';
			innerHtml += '</ul>';
			innerHtml += '</div>';		
			$('#container').append(innerHtml);
			
		}
		
		this.removeChoiceDiv = function(prmtObj){
			$("#div_"+prmtObj.goodsId).remove();
		}
		
		this.plus = function (trgtGoodsId){
			
			for(var i=0;i<p.arrSelGoods.length;i++){
					
					if(p.arrSelGoods[i].goodsId==trgtGoodsId){
						p.arrSelGoods[i].cnt++;
						break;
					}
			}
			
			
			p.afterProc();			
		}
		
		this.minus = function (trgtGoodsId){
			
			for(var i=0;i<p.arrSelGoods.length;i++){
					
					if(p.arrSelGoods[i].goodsId==trgtGoodsId){
						if(p.arrSelGoods[i].cnt==1) break;
						p.arrSelGoods[i].cnt--;
						break;
					}
			}
			
			p.afterProc();			
		}
		
		//계산 후처리.
		this.afterProc = function (){
			
			for(var i=0;i<p.arrSelGoods.length;i++){
				$('#input_cnt_'+p.arrSelGoods[i].goodsId).val(p.arrSelGoods[i].cnt);
				$('#input_sumAmt_'+p.arrSelGoods[i].goodsId).val(p.arrSelGoods[i].cnt*p.arrSelGoods[i].goodsprc);
			}
			
			var goodsTotAmt = 0;
			for(var i=0;i<p.arrSelGoods.length;i++){
				goodsTotAmt += p.arrSelGoods[i].cnt*p.arrSelGoods[i].goodsprc;
			}
			$('#goodsTotAmt').val(goodsTotAmt);
			
		}
	}
				
	var goods = new Goods();
	
	
	//${product};
// 	for(Product pro : ${product}){
<%-- 		<%for(Product ppp : pro){%> --%>
<%-- 		Product abc = <%=pro%>.shift(); --%>
// 		console.log(abc);
<%-- 	<%}%> --%>
// 	goods.arrAllGoods.push({goodsId:"셔츠",goodsprc:"1500",goodsNm:"셔츠",cnt:0});
	
// 	List<Product> product = $("#product").val();
// 	for(var i=0;i<product.length;i++){
// 	var pname = new Array(); 
// 	var pprice = new Array();
		for(var i=0;i<$('input[name="pname"]').length;i++){
// 			pname.push($('input[name="pname"]').eq(i).val());
// 			pprice.push($('input[name="pprice"]').eq(i).val());
    		goods.arrAllGoods.push({goodsId:$('input[name="pname"]').eq(i).val(),goodsprc:$('input[name="pprice"]').eq(i).val(),goodsNm:$('input[name="pname"]').eq(i).val(),cnt:0});  
			
		}
// 		console.log(pname);
// 		console.log(pprice);
		
// 	}
	
// 	goods.arrAllGoods.push({goodsId:"셔츠",goodsprc:"1500",goodsNm:"셔츠",cnt:0});
//     goods.arrAllGoods.push({goodsId:"블라우스",goodsprc:"2000",goodsNm:"블라우스",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"티셔츠",goodsprc:"2000",goodsNm:"티셔츠",cnt:0});  
// 	goods.arrAllGoods.push({goodsId:"맨투맨",goodsprc:"2000",goodsNm:"맨투맨",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"바지",goodsprc:"2000",goodsNm:"바지",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"니트",goodsprc:"2000",goodsNm:"니트",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"자켓",goodsprc:"2000",goodsNm:"자켓",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"코트",goodsprc:"2000",goodsNm:"코트",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"패딩",goodsprc:"2000",goodsNm:"패딩",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"이불",goodsprc:"2000",goodsNm:"이불",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"신발",goodsprc:"2000",goodsNm:"신발",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"커튼",goodsprc:"2000",goodsNm:"커튼",cnt:0});
// 	goods.arrAllGoods.push({goodsId:"가방",goodsprc:"2000",goodsNm:"가방",cnt:0});
	 
	$(function(){
		$('#selGoods').change('click',function(){
			
			//alert(this.value);
 			goods.select($('#selGoods option:selected').val());
		}); 
	});	
</script>



						</div>
						<span class="info_revise">업데이트 <span class="date_revise">2019.03.14.</span>
							<span class="bg_bar">|</span> <a href="#" class="link_fiy"
							data-fiytype="detail" data-logtarget=""
							data-logevent="main_info,FIY">틀린정보 신고</a></span>
					</div>
				</div>
				<div data-viewid="photoSection" data-root=""
					class="cont_photo no_category">
					<div class="particular_head">
						<h3 class="tit_subject">사진</h3>

						<div class="wrap_btn">
							<a href="#none" class="link_enroll" data-fiytype="photo"
								data-logtarget="" data-logevent="photo,add"> <span
								class="ico_comm ico_photo"></span>사진등록
							</a>
						</div>
					</div>
					<div class="photo_area">
						<ul class="list_photo">
							<li class="">사진 2장 부터 클래스 size_l 추가 <a href="#none"
								class="link_photo" data-pidx="0"
								style="background-image: url('//img1.daumcdn.net/thumb/C640x320.q70/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flocalfiy%2F2D6916B41D7C492EB7A93CEFC2F357AA')"
								data-logtarget="" data-logevent="photo,photo_view"> <span
									class="frame_g"></span>
							</a>
							</li>
						</ul>

					</div>
					<br>



					<section id="container">
						<h4 class="review">리뷰</h4>
						<form role="form" method="get">
							<table>
								<tr>
									<th>리뷰번호</th>
									<th>내용</th>
									<th>작성자</th>
									<th>등록일</th>
									<th>별점</th>
								</tr>

								<c:forEach items="${reviewList}" var="reviewList">

									<c:set var="star0" value="${reviewList.star}" />
									<c:choose>
										<c:when test="${star0 eq '1' }">
											<c:set var="star1" value="${fn:replace(star0, '1', '★' ) }" />
										</c:when>

										<c:when test="${star0 eq '2' }">
											<c:set var="star1" value="${fn:replace(star0, '2', '★★')  }" />
										</c:when>


										<c:when test="${star0 eq '3' }">
											<c:set var="star1" value="${fn:replace(star0, '3', '★★★' ) }" />
										</c:when>


										<c:when test="${star0 eq '4' }">
											<c:set var="star1"
												value="${fn:replace(star0, '4', '★★★★')  }" />
										</c:when>


										<c:when test="${star0 eq '5' }">

											<c:set var="star1"
												value="${fn:replace(star0, '5', '★★★★★')  }" />
										</c:when>


									</c:choose>


									<tr>
<%-- 										<td><c:out value="${reviewList.r_no}" /></td> --%>
										<td><c:out value="${reviewList.r_content}" /></td>
										<td><c:out value="${reviewList.w_id}" /></td>
										<td><fmt:formatDate value="${reviewList.r_date}"
												pattern="yyyy-MM-dd" /></td>
										<td class="starcolor"><c:out value="${star1}" /></td>
									</tr>
								</c:forEach>

							</table>
						</form>
					</section>

				</div>


		
				<div>
					<button onClick="javascript:goDetail('테스트');">문의글 작성하기</button>
					<div style="height: 1000px;"></div>

					<!-- 팝업뜰때 배경 -->
					<div id="mask"></div>


					<div id="layerbox" class="layerpop"
						style="width: 700px; height: 350px;">
						<article class="layerpop_area">
							<div class="title">문의하기</div>
							<a href="javascript:popupClose();" class="layerpop_close"
								id="layerbox_close"></a> <br>

							<form name="writeForm" method="post" action="/user/schatW">
								<table>
									<tbody>
									
									<tr>
											<td><label for="writer">업체명</label><input type="text"
												id="sname" name="sname" placeholder="ID가져올 예정"
												value="${storeInfo.sname}" readOnly /></td>
										<tr>
									

										<tr>
											<td><label for="content">제목</label> <textarea
													id="c_title" name="c_title" class="chk" title="제목을 입력하세요."
													placeholder="내용을 입력해주세요"></textarea></td>
										</tr>

										<tr>
											<td><label for="content">내용</label> <textarea
													id="c_content" name="c_content" class="chk"
													title="내용을 입력하세요." placeholder="내용을 입력해주세요"></textarea></td>
										</tr>
										<tr>
											<td><label for="writer">작성자</label><input type="text"
												id="writer" name="w_id" placeholder="ID가져올 예정"
												value="${loginMember.id}" /></td>
										<tr>
										<tr>
											<td><label for="writer"></label><input type="hidden"
												id="grade" name="g_check" placeholder="회원등급 가져올예정"
												value="${loginMember.grade}" /></td>
										<tr>
										<tr>
											<td><label for="writer"></label><input type="hidden"
												id="snum" name="snum" value='${storeInfo.snum}'
												placeholder="사업자번호 가져올예정" /></td>
										<tr>

											<td>
												<button type="submit" class="write_btn">작성하기</button>
											</td>
										</tr>

										<!-- <tr>
											<td>
												<button onclick="javascript:popupClose() ;">취소</button>
											</td>
										</tr>
 -->
									</tbody>
								</table>
							</form>

						</article>
					</div>
				</div>
				</div>
				
				<!--Popup End -->
</body>
</html>

