$(document).ready(function () {
  $("#contact-name").on("input", function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#contact-name");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#contact-email").on("input", function () {
    const valid = !validator.isEmail(this.value);
    const input = $("#contact-email");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#contact-phone").on("input", function () {
    const valid = !validator.isMobilePhone(this.value, "en-CA");
    const input = $("#contact-phone");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#contact-business").on("input", function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#contact-business");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#contact-project").on("input", function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#contact-project");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#contact-department").change(function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#contact-department");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#contact-description").on("input", function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#contact-description");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#contact-message").on("input", function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#contact-message");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#contact-attachment").on("input", function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#contact-attachment");
    valid ? input.addClass("error") : input.removeClass("error");
  });
});
