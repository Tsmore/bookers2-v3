/*global $*/
// ページ読み込み開始時に.contentを非表示にする
document.addEventListener('turbolinks:request-start', function () {
    const content = document.querySelector(".content");
    const loader = document.querySelectorAll(".loader", ".loader-bg")
    content.style.visibility = "hidden";
    loader.style.visibility = "visible";
});
// ロードが完了したら.loaderを非表示にし、.contentを表示する
document.addEventListner('turbolinks:load', function () {
    const loader = document.querySelectorAll(".loader", ".loader-bg");
    const content = document.querySelector(".content")
    content.style.visibility = "visible";
    loader.style.visibility = "hidden";
});
