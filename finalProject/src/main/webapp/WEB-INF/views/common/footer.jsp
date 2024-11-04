<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
		<!-- main footer -->
		<footer class="main_footer">
			<button type="button" class="btn to_top">
				<span class="blind">To Top</span>
			</button>
			<section class="ft_info_wrap">
				<div class="ft_info">
					<div class="ft_info__item">
						<div class="ft_logo_wrap"><div class="ft_logo"></div></div>
						<div class="ft_textbox mb-5">
							<p>Powerlift is a champ in providing its users with absolutely everything a fitness or gym site needs.</p>
						</div>
						<div class="textbox">
							<h3 class="ft_info__title">Our socials</h3>
							<div class="ft_sns_wrap">
								<a href="#" class="ft_sns sns_instagram" title="인스타그램"></a>
								<a href="#" class="ft_sns sns_facebook" title="페이스북"></a>
								<a href="#" class="ft_sns sns_twitter" title="트위터"></a>
							</div>
						</div>
					</div>
					<div class="ft_info__item">
						<h3 class="ft_info__title">LOCATIONS</h3>
						<img width="300" height="155" src="https://powerlift.qodeinteractive.com/wp-content/uploads/2019/06/futer-map-img-300x155.png" class="image wp-image-598  attachment-medium size-medium" alt="a" style="max-width: 100%; height: auto;" srcset="https://powerlift.qodeinteractive.com/wp-content/uploads/2019/06/futer-map-img-300x155.png 300w, https://powerlift.qodeinteractive.com/wp-content/uploads/2019/06/futer-map-img.png 304w" sizes="(max-width: 300px) 100vw, 300px" loading="eager">
						<p class="mt10 mb-0">
							<a href="#" class="ft_info__link" target="_blank" rel="nofollow noopener">251 Purple Sunset Avenue<br>Brooklyn, BXY 92101</a>
						</p>
					</div>
					<div class="ft_info__item">
						<div class="textbox">
							<h3 class="ft_info__title">Working hours</h3>
							<p>Monday - Friday:<br>07:00 - 21:00</p>
							<p>Saturday:<br>07:00 - 16:00</p>
							<p>Sunday Closed</p>
						</div>
					</div>
				</div>
			</section>
			<section class="ft_copyright_wrap">
				<div class="ft_copyright">© 2024 KH ACADEMY, All Rights Reserved</div>
			</section>
		</footer>
	<script>
	$(window).scroll(function() {
		const scrollPosition = $(window).scrollTop();
		const windowHeight = $(window).height();
		const documentHeight = $(document).height();
		
		const footerHeight = 425;  // footer 높이

		// header 높이를 넘어섰을 때 to_top_on 클래스를 추가해 버튼 표시
		if (scrollPosition > 50) {
			$('.to_top').addClass('to_top_on');
		} else {
			$('.to_top').removeClass('to_top_on');
		}

		// footer가 화면에 도달하면 to_top_on 클래스를 제거해 버튼 숨기기
		if (scrollPosition + windowHeight >= documentHeight - footerHeight || scrollPosition === 0) {
			$('.to_top').removeClass('to_top_on');
		}
	});

	$('.to_top').click(function() {
		$('html, body').animate({ scrollTop: 0 }, 'smooth');
	});
	</script>