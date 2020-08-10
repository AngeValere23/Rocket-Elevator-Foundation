$(document).ready(function () {
  $("#newsletter-email").on("input", function () {
    const valid = !validator.isEmail(this.value);
    const input = $("#newsletter-email");
    valid ? input.addClass("error") : input.removeClass("error");
  });
});
