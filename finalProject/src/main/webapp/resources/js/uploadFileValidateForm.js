function validateForm() {
    const maxFileSize = 10 * 1024 * 1024; // 개별 파일 최대 크기 10MB
    const maxTotalSize = 10 * 1024 * 1024; // 총 파일 크기 제한 10MB
    const fileInputs = document.querySelectorAll('input[type="file"]'); // 모든 파일 입력 요소 선택
    let totalSize = 0; // 총 파일 크기 초기화

    fileInputs.forEach(input => {
        const files = input.files;
        for (let i = 0; i < files.length; i++) {
            const fileSize = files[i].size;
            
            // 개별 파일 크기 검사
            if (fileSize > maxFileSize) {
                alert("파일의 크기가 10MB를 초과합니다.(업로드 불가)");
                return false;
            }

            totalSize += fileSize; // 총 파일 크기 누적
        }
    });

    // 총 파일 크기 검사
    if (totalSize > maxTotalSize) {
        alert("첨부한 파일의 총 크기가 10MB를 초과합니다.");
        return false;
    }

    return true; // 유효성 검사 통과 여부 반환
}

// 모든 폼에 유효성 검사 적용
document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll('form[enctype="multipart/form-data"]').forEach(form => {
        form.addEventListener('submit', function(event) {
            if (!validateForm()) {
                event.preventDefault(); // 유효성 검사 실패 시 폼 제출 방지
            }
        });
    });
});