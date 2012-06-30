<?php
/****************************************************
CallerService.php

This file uses the constants.php to get parameters needed 
to make an API call and calls the server.if you want use your
own credentials, you have to change the constants.php

Called by TransactionDetails.php, ReviewOrder.php, 
DoDirectPaymentReceipt.php and DoExpressCheckoutPayment.php.

****************************************************/
$API_UserName='pradee_1332324973_biz_api1.zhservices.com';
$API_Password='1332324993';
$API_Signature='AFcWxV21C7fd0v3bYYYRCpSSRl31ASh58JiqMRQg94gl0iRFYVSC2fVW';
$API_Endpoint ='https://api-3t.sandbox.paypal.com/nvp';
$version=urlencode('51.0');




/**
  * hash_call: Function to perform the API call to PayPal using API signature
  * @methodName is name of API  method.
  * @nvpStr is nvp string.
  * returns an associtive array containing the response from the server.
*/


function hash_call($methodName,$nvpStr)
{
    $_SESSION['nvpReqArray']='';
    $_SESSION['curl_error_no']='';
    $_SESSION['curl_error_msg']='';
    
    $API_UserName='pradee_1339587675_biz_api1.zhservices.com';
    $API_Password='1339587713';
    $API_Signature='AkLZIuO-LKkA1TSAeoEBD3dkzIc4AKb3.ebscal3VYeJ4-cZbEqd8TXY';
    $API_Endpoint ='https://api-3t.sandbox.paypal.com/nvp';
    $version=urlencode('51.0');
    
	//declaring of global variables
	// form header string

	$nvpHeaderStr = "&VERSION=$version&PWD=".urlencode($API_Password)."&USER=".urlencode($API_UserName)."&SIGNATURE=".urlencode($API_Signature);
	//die;
	//setting the curl parameters.
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,$API_Endpoint);
	curl_setopt($ch, CURLOPT_VERBOSE, 1);

	//turning off the server and peer verification(TrustManager Concept).
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_POST, 1);
	
	
	
	$nvpStr=$nvpHeaderStr.$nvpStr;
	
    
	
	$nvpreq="METHOD=".urlencode($methodName).$nvpStr;
	//echo $nvpreq;
	//setting the nvpreq as POST FIELD to curl
	curl_setopt($ch,CURLOPT_POSTFIELDS,$nvpreq);

	//getting response from server
	$response = curl_exec($ch);
	
	 if (curl_errno($ch) == 60) { 
	     
	
      
        curl_setopt($ch, CURLOPT_CAINFO,
        dirname(__FILE__) . '/cacert.pem');
        $response = curl_exec($ch);
    }

	//convrting NVPResponse to an Associative Array
	$nvpResArray=deformatNVP($response);
	$nvpReqArray=deformatNVP($nvpreq);
	$_SESSION['nvpReqArray']=$nvpReqArray;

	if (curl_errno($ch)) {
		// moving to display page to display curl errors
		  $_SESSION['curl_error_no']=curl_errno($ch) ;
		  $_SESSION['curl_error_msg']=curl_error($ch);
		  
		//  $location = "APIError.php";
		 // header("Location: $location");
	 } else {
		 //closing the curl
			curl_close($ch);
	  }

return $nvpResArray;
}

function hash_call_direct($methodName,$nvpStr)
{
	$_SESSION['nvpReqArray']='';
	$_SESSION['curl_error_no']='';
	$_SESSION['curl_error_msg']='';

	$API_UserName='pradee_1339587675_biz_api1.zhservices.com';
	$API_Password='1339587713';
	$API_Signature='AkLZIuO-LKkA1TSAeoEBD3dkzIc4AKb3.ebscal3VYeJ4-cZbEqd8TXY';
	$API_Endpoint ='https://api-3t.sandbox.paypal.com/nvp';
	$version=urlencode('56.0');

	//declaring of global variables
	// form header string

	$nvpHeaderStr = "&VERSION=$version&PWD=".urlencode($API_Password)."&USER=".urlencode($API_UserName)."&SIGNATURE=".urlencode($API_Signature);
	//die;
	//setting the curl parameters.
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,$API_Endpoint);
	curl_setopt($ch, CURLOPT_VERBOSE, 1);

	//turning off the server and peer verification(TrustManager Concept).
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
	curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);

	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_POST, 1);



	$nvpStr=$nvpHeaderStr.$nvpStr;



	$nvpreq="METHOD=".urlencode($methodName).$nvpStr;
	//echo $nvpreq;
	//setting the nvpreq as POST FIELD to curl
	curl_setopt($ch,CURLOPT_POSTFIELDS,$nvpreq);

	//getting response from server
	$response = curl_exec($ch);

	if (curl_errno($ch) == 60) {



		curl_setopt($ch, CURLOPT_CAINFO,
		dirname(__FILE__) . '/cacert.pem');
		$response = curl_exec($ch);
	}

	//convrting NVPResponse to an Associative Array
	$nvpResArray=deformatNVP($response);
	$nvpReqArray=deformatNVP($nvpreq);
	$_SESSION['nvpReqArray']=$nvpReqArray;

	if (curl_errno($ch)) {
		// moving to display page to display curl errors
		$_SESSION['curl_error_no']=curl_errno($ch) ;
		$_SESSION['curl_error_msg']=curl_error($ch);

		//  $location = "APIError.php";
		// header("Location: $location");
	} else {
		//closing the curl
		curl_close($ch);
	}

	return $nvpResArray;
}
/** This function will take NVPString and convert it to an Associative Array and it will decode the response.
  * It is usefull to search for a particular key and displaying arrays.
  * @nvpstr is NVPString.
  * @nvpArray is Associative Array.
  */

function deformatNVP($nvpstr)
{

	$intial=0;
 	$nvpArray = array();


	while(strlen($nvpstr)){
		//postion of Key
		$keypos= strpos($nvpstr,'=');
		//position of value
		$valuepos = strpos($nvpstr,'&') ? strpos($nvpstr,'&'): strlen($nvpstr);

		/*getting the Key and Value values and storing in a Associative Array*/
		$keyval=substr($nvpstr,$intial,$keypos);
		$valval=substr($nvpstr,$keypos+1,$valuepos-$keypos-1);
		//decoding the respose
		$nvpArray[urldecode($keyval)] =urldecode( $valval);
		$nvpstr=substr($nvpstr,$valuepos+1,strlen($nvpstr));
     }
	return $nvpArray;
}
function formAutorization($auth_token,$auth_signature,$auth_timestamp)
{
	$authString="token=".$auth_token.",signature=".$auth_signature.",timestamp=".$auth_timestamp ;
	return $authString;
}
?>
