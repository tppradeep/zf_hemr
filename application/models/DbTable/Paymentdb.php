<?php

class Application_Model_DbTable_Paymentdb extends Zend_Db_Table_Abstract
{

    protected $_name = 'hosted_facilities';

	public function PlanOneTimePayment_sum($pid,$hf_id,$qty)
	{
		
		$db = Zend_Db_Table::getDefaultAdapter();
		
		$select = $db->select()
		->from(array('hosted_plans'),array('bundle_discount_type','bundle_discount_per_setup'))
		->where('hp_id='.$pid);
		$row = $db->fetchrow($select);
		
		$bundle_discount_type = $row['bundle_discount_type'];
		$bundle_discount_per_setup = $row['bundle_discount_per_setup'];
		
		
		$select = $db->select()
		->from(array('h' => 'customer_products'),array('count(h.idcustomer_products)'))
		->where('h.cost>0')
		->where('h.hp_id='.$pid)
		->where('h.hf_id='.$hf_id);
		
		$row = $db->fetchOne($select);
		
		if($row>0)
		{

		
		$select = $db->select()
		->from(array('h' => 'customer_products'),array('sum(h.cost)'))
		->where('h.hp_id='.$pid)
		->where('h.hf_id='.$hf_id);
		
		$row = $db->fetchOne($select);
		
		$row = $row * $qty;
		}
		
		if($bundle_discount_type==1)
		{
			$discount = $row * $bundle_discount_per_setup / 100;
			$row = $row - $discount;
		}
		if($bundle_discount_type==2)
		{
			$discount = $row - $bundle_discount_per_setup ;
			$row = $row - $discount;
		}
		
		return $row;
	}
	
	public function PlanMonthlyPayment_sum($pid,$hf_id,$qty)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    //First Fetching the Plan wise discount setup informations
		
	    $select = $db->select()
	    			 ->from(array('hosted_plans'),array('bundle_discount_type','bundle_discount_per_cost'))
					 ->where('hp_id='.$pid);
		$row = $db->fetchrow($select);
		
		$bundle_discount_type = $row['bundle_discount_type'];
		$bundle_discount_per_cost = $row['bundle_discount_per_cost'];
		
		
		$select = $db->select()
			->from(array('h' => 'customer_products'),array('count(h.idcustomer_products)'))
			->where('h.cost>0')
			->where('h.hp_id='.$pid)
			->where('h.hf_id='.$hf_id);

		 $row = $db->fetchOne($select);
		 
		if($row>0)
		{
		
		$select = $db->select()
		->from(array('h' => 'customer_products'),array('sum(h.cost)'))
		->where('h.hp_id='.$pid)
		->where('h.hf_id='.$hf_id);
	
		$row = $db->fetchOne($select);
		
		}
		if($row=="")
			$row=0;
		$row = $row * $qty;
		if($bundle_discount_type==1)
		{
		    $discount = $row * $bundle_discount_per_cost / 100;
			$row = $row - $discount;
		}
		if($bundle_discount_type==2)
		{
			$row = $row - $bundle_discount_per_cost;
		}
		
		return $row;
	}
	public function discountplan($pid,$uid)
	{
		$anualpayment = $this->PlanOneTimePayment_sum($pid,$uid);
		$monthlypayment = $this->PlanMonthlyPayment_sum($pid,$uid);
			
		
		//select * from hosted_plans where hp_id=15 and curdate() between discount_start_date and discount_end_date
		$db=Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from (array('hosted_plans'),array('discount'))
		->where ('hp_id = ?', $pid)
		->where ('curdate() between discount_start_date and discount_end_date');
		
		return $dis_percentage = $db->fetchOne($select);
		
		//return $dis_amount = (($anualpayment+$monthlypayment)*$dis_percentage)/100;
	}
	/*
	 * Checking if any discount is application for the plan on this period. if yes,
	 * calcuating the discount amount.
	 */
	public function DiscountCheck($pid,$uid)
	{
		
				
		$anualpayment = $this->PlanOneTimePayment_sum($pid,$uid);
		$monthlypayment = $this->PlanMonthlyPayment_sum($pid,$uid);
			
				
		//select * from hosted_plans where hp_id=15 and curdate() between discount_start_date and discount_end_date
		$db=Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		 		->from (array('hosted_plans'),array('discount'))
    			->where ('hp_id = ?', 15)
    			->where ('curdate() between discount_start_date and discount_end_date');
		
		$dis_percentage = $db->fetchOne($select);
		
		$dis_amount = (($anualpayment+$monthlypayment)*$dis_percentage)/100;
		
		$gross_amount = ($anualpayment+$monthlypayment)-$dis_amount;
		/*
		 * UPDATING THE VALUES IN customer_selected_plan TABLE !!!
		 */
		
			$data = array('one_time_payment' =>$anualpayment,
	                  'monthly_payment' => $monthlypayment,
	                  'discount_percentage' => $dis_percentage,
	                  'discount_amount' => $dis_amount,
					  'total_payment'=>$gross_amount
	                  );
			$db->update('customer_selected_plan', $data,'hf_id = '.$uid.' and plan_id='.$pid.'');
		

		return $dis_percentage;
	
	}
	public function InvoiceNumber($linId)
	{
		/*invoice format
		 * ZH-2012-12-23-34343
		 */
		$today = date("Y-m-d");
		$invoice_no = "ZH-".$today;
		
		$db=Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
					 ->from (array('customer_invoice'),array('MAX(idcustomer_invoice)'));
		
		$maxid = $linId;
		
		
		if(strlen($maxid)==1)
			$mval = "0000".$maxid;
		elseif(strlen($maxid)==2)
			$mval = "000".$maxid;
		elseif(strlen($maxid)==3)
			$mval = "00".$maxid;
		elseif(strlen($maxid)==4)
			$mval = "0".$maxid;
		else 
			$mval = $maxid;
		
		return $invoice_no = $invoice_no."-".$mval;
	}
	public function invoiceaddress($hf_id)
	{
		$db=Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
					->from (array('hosted_facilities'),array('hf_facility_name','hf_address','hf_city','hf_zip','hf_state','hf_country','hf_email','hf_phone','hf_fax'))
					->where('hf_id='.$hf_id);
		return $db->fetchRow($select);
	}
	public function invoiceaddress_invoice($invoice_number)
	{
		$db=Zend_Db_Table::getDefaultAdapter();
		$select = $db->query("CALL user_details_t_invoice_no('$invoice_number')");
		return $result=$select->fetchAll();
	
	}
	
	
	public function plan_name($pid)
	{
		$db=Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		->from (array('hosted_plans'),array('hp_name'))
		->where('hp_id='.$pid);
		return $db->fetchOne($select);
	}
	public function Add_Invoice($plan_id,$hf_id) // Adding Plan Subscription Invoice after user registration
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$discountpercentage=0;
		/*
		 * Adding invoice data into table. Once the registration is completed this invoice will genrate
		 */
		
		
		$invoice_number = "new";
		$particulars="";
		$select = $db->select()
		->from (array('cart'),array('idcart','plan_id','product_id','hf_id','description','qty_from','qty','unit_price','setupfee','discount','setupfee_discount','cart_date'))
		->where('cartsession="'.session_id().'"')
		->where('cstatus=0')
		->where('invoice_no is null')
		->where('hf_id='.$hf_id);
		
		$cartdtd=$db->fetchAll($select);

		
		$PlanOneTimePayment_sum=0;
		$PlanMonthlyPayment_sum=0;
		$discountplan=0;
		$amount=0;
		$invoice_date = date("Y-m-d");
		$payment_status = "Pending";
		$setupfee=0;
		$subscription_amount=0;
		foreach($cartdtd as $CD)
		{
		    if($CD['plan_id']!=0) // It means the cart item is a plan so discount settings required to apply
		    {
		        $particulars = $particulars.$CD['description'].",";
		        $PlanOneTimePayment_sum = $PlanOneTimePayment_sum + $this->PlanOneTimePayment_sum($CD['plan_id'],$hf_id,$CD['qty']);
		        $PlanMonthlyPayment_sum = $PlanMonthlyPayment_sum + $this->PlanMonthlyPayment_sum($CD['plan_id'],$hf_id,$CD['qty']);
		        $discountplan = $discountplan + $CD['discount'] + $CD['setupfee_discount'];
		      //  $amount = $amount + ($CD['qty'] * $CD['unit_price'])- $CD['discount'];
		        
		        //$subscription_amount = $subscription_amount + $PlanMonthlyPayment_sum;
		        $setupfee = $setupfee + $CD['setupfee']-$CD['setupfee_discount'];
		        
		    }
		    if($CD['plan_id']==0)
		    {
		        $particulars = $particulars.$CD['description'].",";
		        $particulars= substr($particulars, 0, -1);
		        $productid=$CD['product_id'];
		        
		        $row = $db->query("CALL product_payment_term($productid)"); // Its a procedure call
		        $ProDtd=$row->fetchAll();
		        	
		         
		       	$PlanMonthlyPayment_sum = $PlanMonthlyPayment_sum + $CD['unit_price']*$CD['qty'];
		        $setupfee = $setupfee + $ProDtd[0]['setup_fee'];
		       // $amount = $amount + ($CD['qty'] * $CD['unit_price']);
		    }
		}
		$data = array(
					'plan_id' => $plan_id,
					'hf_id' => $hf_id,
					'invoice_number' => $invoice_number,
			        'cartsessionid'=> session_id(),
					'particulars' => addslashes($particulars),
					'amount' => $PlanMonthlyPayment_sum,
			        'setupfee'=>$setupfee,
					'payment_status' => $payment_status,
					'status_message' => $payment_status,
					'invoice_date' => $invoice_date,
					'subscription_amount' => $PlanMonthlyPayment_sum,
					'discount_percentage'=>$discountpercentage,
					'discount_amount'=>$discountplan
				);
	
			$numRows = $db->insert('customer_invoice', $data);
			$linId=$db->lastInsertId();
			$invoice_number = $this->InvoiceNumber($linId);
			
			$data = array('invoice_number' =>$invoice_number);
			$db->update('customer_invoice', $data,'idcustomer_invoice = '.$linId.'');
					 
			$cart_invoice_data=array('invoice_no'=>$invoice_number);
			$ses = session_id();
			$db->update('cart',$cart_invoice_data,'cartsession="'.$ses.'"');

		return $invoice_number;
	}
	public function invoicedetails($invoiceId)
	{
		$db=Zend_Db_Table::getDefaultAdapter();
		
		$select = $db->select()
		->from (array('customer_invoice'),array('idcustomer_invoice','plan_id','hf_id','invoice_number','particulars','amount','setupfee','payment_date','payment_date','payment_status','transaction_id','status_message','invoice_date','paypal_string','subscription_amount','subscr_id','discount_percentage','discount_amount'))
		->where('invoice_number="'.$invoiceId.'"');
		//$invdtd=$db->fetchAll($select);
		
		return $db->fetchRow($select);
	}
	public function Confirm_invoice($hf_id,$invoice_number,$particulars,$payment_date,$payment_status,$transaction_id,$req,$subscr_id)
	{
	   
		/*
		 * Updating the payment status in customer_invoice table
		 * IPN execution script
		 */
//		$payment_status="COMPLETED"; // have to remove before making online
		$db=Zend_Db_Table::getDefaultAdapter();
		$data = array('payment_status' =>$payment_status,
				'subscr_id' => $subscr_id,
				'payment_date' => $payment_date,
				'transaction_id' => $transaction_id,
				'paypal_string'=>$req
		);
		
		$db->update('customer_invoice', $data,'invoice_number = "'.$invoice_number.'"');
		
		
		$select = $db->select()
		->from (array('customer_invoice'),array('plan_id'))
		->where('invoice_number="'.$invoice_number.'"');
		$plan_id = $db->fetchOne($select);
		
		/* update cart items status to one
		 * 
		 */
		
		$data = array('cstatus'=>1);
		$db->update('cart', $data,'invoice_no = "'.$invoice_number.'"'); // not working have to check
		
		// Updating  Customer Plan Status
		if(strtolower($payment_status)=="completed")
		{
			$plan_status = 1;
		}
		else
		{
			$plan_status = 0;
		}
		$db=Zend_Db_Table::getDefaultAdapter();
		$plan_activated_date = date('Y-m-d');
		$data = array('payment_status' =>$payment_status,
				'plan_status' => $plan_status,
				'payment_date' => $payment_date,
				'payment_error_message' => '',
				'plan_activated_date'=>$plan_activated_date
		);
		
		$db->update('customer_selected_plan', $data,'hf_id = '.$hf_id.' and plan_id='.$plan_id);
		
		
		
		
		
		if(strtolower($payment_status)=="completed" && $plan_id==0)
		{
		   // update plan details with added new products
			
			
		}
		
	}
	/*public function Update_Customer_Selected_Plan($plan_id,$hf_id,$payment_status,$payment_date)
	{
		//$payment_status="COMPLETED"; // have to remove before making online
		if($payment_status=="COMPLETED")
		{
			$plan_status = 1;			
		}
		else
		{
			$plan_status = 0;
		}
		$db=Zend_Db_Table::getDefaultAdapter();
		$plan_activated_date = date('Y-m-d');
		$data = array('payment_status' =>$payment_status,
				'plan_status' => $plan_status,
				'payment_date' => $payment_date,
				'payment_error_message' => '',
				'plan_activated_date'=>$plan_activated_date
		);
		
		$db->update('customer_selected_plan', $data,'hf_id = '.$hf_id.' and plan_id='.$plan_id);
	}
	public function updateinvoice($formdata)
	{
	   // echo "<pre>";
	   // print_r($formdata);
	    $InvoiceNo=$formdata['cm'];
	    $PayStatus=$formdata['st'];
	    $transactionid=$formdata['tx'];
	    $db=Zend_Db_Table::getDefaultAdapter();
	    $plan_activated_date = date('Y-m-d');
	    
	    $data = array('cstatus' =>1 );
	    $db->update('cart', $data,'invoice_no = "'.$InvoiceNo.'"');
	    
	    $paymentdate=date('Y-m-d');
	   	$data = array('payment_status' =>$PayStatus,
				'transaction_id' => $transactionid,
				'payment_date' => $paymentdate
		);
	   	
	   	$db->update('customer_invoice', $data,'invoice_number = "'.$InvoiceNo.'"');
	}*/
	public function ProductUpdateToPlan($hf_id,$invoice_number,$payment_date,$payment_status,$transaction_id)
	{
	    $db=Zend_Db_Table::getDefaultAdapter();
	    //Fetching Plan ID of the user to link the new products into the exisitng plan
	    $select = $db->select()
	    ->from (array('customer_selected_plan'),array('plan_id'))
	    ->where('hf_id='.$hf_id);
	    $plan_id=$db->fetchOne($select);
	    	    
	    
	    // Fetching all products 
	    $select = $db->select()
				    ->from (array('cart'),array('product_id','qty_from','qty','unit_price'))
				    ->where('invoice_no="'.$invoice_number.'"')
				    ->where('hf_id='.$hf_id)
				    ->where('plan_id=0')
				    ->where('cstatus=1');
	    $pro_id = $db->fetchAll($select);
	    
	    
	    
	 //   echo "<pre>";
	//    print_r($pro_id);
	    foreach($pro_id as $productid)
	    {
	        $select1 = $db->select()
	        ->from (array('products'),array('idproducts','product_name','customer_id','product_feature','cost','payment_term','product_sort_order','product_status','added_date'))
	        ->where('idproducts="'.$productid['product_id'].'"');
	        $productdtd = $db->fetchRow($select1);
	        
	        $data = array(
	        		'hf_id' => $hf_id,
	        		'hp_id' => $plan_id,
	        		'idproducts' => $productid['product_id'],
	        		'product_name' => $productdtd['product_name'],
	        		'customer_id' => $productdtd['customer_id'],
	        		'product_feature' => $productdtd['product_feature'],
	                'user_from'=>$productid['qty_from'],
	                'user_to'=>$productid['qty'],
	        		'cost' => $productid['unit_price'],
	        		'payment_term' => $productdtd['payment_term'],
	        		'product_sort_order' => $productdtd['product_sort_order'],
	                'product_status'=>$productdtd['product_status']
	        );
	        
	         
	        
	        $numRows = $db->insert('customer_products', $data);
	        
	        
	    }
	}
	
	
}

