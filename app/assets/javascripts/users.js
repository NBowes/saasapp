/*global $, Stripe */
$(document).on('turbolinks:load',function(){
  var theForm = $('#premium_form');
  var submitBtn = $('#form-submit-btn');
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
    submitBtn.click(function(event){
      event.preventDefault();
      submitBtn.val("Processing").prop('disabled',true);
      var cNum = $('#card_number').val(),
          cvcNum = $('#card_code').val(),
          cMonth = $('#card_month').val(),
          cYear = $('#card_year').val();
      var error = false;
      if(!Stripe.card.validateCardNumber(cNum)){
        error = true;
        alert('Your card number appears to be invalid');
      }
      if(!Stripe.card.validateExpiry(cMonth,cYear)){
        error = true;
        alert('Your card date appears to be invalid');
      }
      if(!Stripe.card.validateCVC(cvcNum)){
        error = true;
        alert('Your card code appears to be invalid');
      }
      if(error){
        submitBtn.val("Sign Up").prop('disabled',false);
      }else{
        Stripe.card.createToken({
            number : cNum,
            cvc : cvcNum,
            exp_month : cMonth,
            exp_year : cYear
        }, stripeResponseHandler);
      }
      return false;
    });
    function stripeResponseHandler(status, response){
      var token = response.id;
      $theForm.append($('<input type="hidden" name="stripeToken">').val(token));
      $theForm.get(0).submit();
    }
});
