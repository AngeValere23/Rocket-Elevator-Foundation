// Local variable
let quality = "standard";
let service;

/// Commercial data
let commercial_shaft;

/// Residential data
let residential_apartment;
let residential_floor;

// Corporate && Hybrid data
let corphyb_occupant;
let corphyb_floor;
let corphyb_basement;

$(document).ready(function () {
  hideAllForm();
  clearForm();
  // Building type change
  $("#building-select").change(function () {
    hideAllForm();
    clearForm();
    const value = $("#building-select").val();
    fixRequired(value);
    if (value === "Residential") {
      $("#residential-form").show();
    } else if (value === "Commercial") {
      $("#commercial-form").show();
    } else if (value === "Corporate") {
      $("#corporate-form").show();
    } else if (value === "Hybrid") {
      $("#hybrid-form").show();
    } else {
      hideAllForm();
    }
  });

  // Quality change
  $("input[name='quality']").change(function () {
    quality = this.value;
    sendRequest();
  });

  // Commercial shaft change
  $("#commercial-shaft").on("input", function () {
    service = "commercial";
    commercial_shaft = this.value;
    sendRequest();
  });

  // Residential change
  $("#residential-apartment").on("input", calcResEl);
  $("#residential-floor").on("input", calcResEl);

  // Corporate change
  $("#corporate-occupant").on("input", { type: "corporate" }, calCorHybEl);
  $("#corporate-floor").on("input", { type: "corporate" }, calCorHybEl);
  $("#corporate-basement").on("input", { type: "corporate" }, calCorHybEl);

  // Hybrid change
  $("#hybrid-occupant").on("input", { type: "hybrid" }, calCorHybEl);
  $("#hybrid-floor").on("input", { type: "hybrid" }, calCorHybEl);
  $("#hybrid-basement").on("input", { type: "hybrid" }, calCorHybEl);

  // Validator
  /// Basic
  $("#building-name").on("input", function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#building-name");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#building-email").on("input", function () {
    const valid = !validator.isEmail(this.value);
    const input = $("#building-email");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#building-phone").on("input", function () {
    const valid = !validator.isMobilePhone(this.value, "en-CA");
    const input = $("#building-phone");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#building-business").on("input", function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#building-business");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#building-project").on("input", function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#building-project");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#building-select").change(function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#building-select");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  /// Residential
  $("#residential-apartment").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#residential-apartment");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#residential-floor").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#residential-floor");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#residential-basement").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#residential-basement");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  /// Commercial
  $("#commercial-business").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#commercial-business");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#commercial-floor").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#commercial-floor");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#commercial-basement").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#commercial-basement");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#commercial-parking").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#commercial-parking");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#commercial-shaft").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#commercial-shaft");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  /// Corporate
  $("#corporate-companies").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#corporate-companies");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#corporate-floor").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#corporate-floor");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#corporate-basement").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#corporate-basement");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#corporate-parking").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#corporate-parking");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#corporate-occupant").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#corporate-occupant");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  /// Hybrid
  $("#hybrid-business").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#hybrid-business");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#hybrid-floor").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#hybrid-floor");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#hybrid-basement").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#hybrid-basement");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#hybrid-parking").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#hybrid-parking");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#hybrid-occupant").on("input", function () {
    const valid = !validator.isInt(this.value);
    const input = $("#hybrid-occupant");
    valid ? input.addClass("error") : input.removeClass("error");
  });
  $("#hybrid-active").change(function () {
    const valid = validator.isEmpty(this.value);
    const input = $("#hybrid-active");
    valid ? input.addClass("error") : input.removeClass("error");
  });

  // Sync fiel
  $("input[name='nbfloor']").on("keyup paste", function () {
    $("input[name='nbfloor']").not(this).val($(this).val());
  });
  $("input[name='nbbasement']").on("keyup paste", function () {
    $("input[name='nbbasement']").not(this).val($(this).val());
  });
  $("input[name='nbparking']").on("keyup paste", function () {
    $("input[name='nbparking']").not(this).val($(this).val());
  });
  $("input[name='nboccupant']").on("keyup paste", function () {
    $("input[name='nboccupant']").not(this).val($(this).val());
  });
  $("input[name='nbbusiness']").on("keyup paste", function () {
    $("input[name='nbbusiness']").not(this).val($(this).val());
  });
});

function hideAllForm() {
  $("#residential-form").hide();
  $("#commercial-form").hide();
  $("#corporate-form").hide();
  $("#hybrid-form").hide();
}

function clearForm() {
  // Commercial
  $("#commercial-shaft").val("");
  // Residential
  $("#residential-apartment").val("");
  $("#residential-floor").val("");
  // Corporate
  $("#corporate-occupant").val("");
  $("#corporate-floor").val("");
  $("#corporate-basement").val("");
  // Hybrid
  $("#hybrid-occupant").val("");
  $("#hybrid-floor").val("");
  $("#hybrid-basement").val("");
  // Clear price
  $("#elevator-number").text("--");
  // Clear shared field
  $("input[name='nbfloor'").val("");
  $("input[name='nbbasement']").val("");
  $("input[name='nbparking']").val("");
  $("input[name='nboccupant']").val("");
  $("input[name='nbbusiness']").val("");
}

function calcResEl() {
  residential_apartment = $("#residential-apartment").val();
  residential_floor = $("#residential-floor").val();

  service = "residential";
  sendRequest();
}

function calCorHybEl(event) {
  corphyb_occupant = $("#" + event.data.type + "-occupant").val();
  corphyb_floor = $("#" + event.data.type + "-floor").val();
  corphyb_basement = $("#" + event.data.type + "-basement").val();
  service = event.data.type;

  sendRequest();
}

function fixRequired(type) {
  // Residential
  $("#residential-apartment").attr("required", type === "Residential");
  $("#residential-floor").attr("required", type === "Residential");
  $("#residential-basement").attr("required", type === "Residential");
  // Commercial
  $("#commercial-business").attr("required", type === "Commercial");
  $("#commercial-floor").attr("required", type === "Commercial");
  $("#commercial-basement").attr("required", type === "Commercial");
  $("#commercial-parking").attr("required", type === "Commercial");
  $("#commercial-shaft").attr("required", type === "Commercial");
  // Corporate
  $("#corporate-companies").attr("required", type === "Corporate");
  $("#corporate-floor").attr("required", type === "Corporate");
  $("#corporate-basement").attr("required", type === "Corporate");
  $("#corporate-parking").attr("required", type === "Corporate");
  $("#corporate-occupant").attr("required", type === "Corporate");
  // Hybrid
  $("#hybrid-business").attr("required", type === "Hybrid");
  $("#hybrid-floor").attr("required", type === "Hybrid");
  $("#hybrid-basement").attr("required", type === "Hybrid");
  $("#hybrid-parking").attr("required", type === "Hybrid");
  $("#hybrid-occupant").attr("required", type === "Hybrid");
  $("#hybrid-active").attr("required", type === "Hybrid");
}

// send AJAX request to Express
function sendRequest() {
  const sentData = {
    quality,
    service,
    commercial_shaft,
    residential_apartment,
    residential_floor,
    corphyb_occupant,
    corphyb_floor,
    corphyb_basement,
  };

  $.ajax({
    type: "POST",
    url: "https://old-rocket-elevators.frederic2ec.tk/quote",
    data: sentData,
  }).done(function (data) {
    updatePricing(data);
  });
}

function updatePricing(data) {
  const elevatorNb = data.elevatorNb;
  const elevatorPrice = data.elevatorPrice;
  const subtotal = data.subtotal;
  const installFee = data.installFee;
  const total = data.total;

  if (total !== "0.00") {
    // User interface
    $("#elevator-number").text(elevatorNb);
    $("#elevator-price").text("$ " + elevatorPrice);
    $("#elevator-subtotal").text("$ " + subtotal);
    $("#elevator-fee").text("$ " + installFee);
    $("#elevator-total").text("$ " + total);
    // Hidden field
    $("#nbelevator").val(elevatorNb);
    $("#elevatorprice").val(elevatorPrice);
    $("#subtotal").val(subtotal);
    $("#installfee").val(installFee);
    $("#total").val(total);
  } else {
    $("#elevator-number").text("--");
    $("#elevator-price").text("--");
    $("#elevator-subtotal").text("--");
    $("#elevator-fee").text("--");
    $("#elevator-total").text("--");
  }
}
