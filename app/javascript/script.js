/*global $*/
// ページ読み込み開始時に .content を非表示にする
document.addEventListener('turbolinks:request-start', function () {
    const content = document.querySelector(".content");
    const loader = document.querySelector(".loader");
    content.style.display = "none";
    loader.style.display = "block";
});

// ロードが完了したら .loader を非表示にし、.content を表示する
document.addEventListener('turbolinks:load', function () {
    const loader = document.querySelector(".loader");
    const content = document.querySelector(".content");
    content.style.display = "block";
    loader.style.display = "none";
});
