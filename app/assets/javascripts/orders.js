$(document).ready(function() {
  var stripe = Stripe("pk_test_lRNDpr2peodb274TdjT2FuAc");
  var $checkoutButton = $("#checkout-btn");
  var $token = $('meta[name="csrf-token"]').prop("content");

  $checkoutButton.on("click", function() {
    event.preventDefault();
    event.stopPropagation();

    $.ajax({
      url: "/charges",
      type: "post",
      dataType: "json",
      headers: {"X-CSRF-TOKEN": $token},
      success: function(response) {
        stripe.redirectToCheckout({
          sessionId: response.charge.id
        });
      },
      error: function(response) {
        console.log(response);
      }
    })
  });
});