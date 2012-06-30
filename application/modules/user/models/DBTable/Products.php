<?php

class User_Model_DbTable_Products extends Zend_Db_Table_Abstract
{

    protected $_name = 'products';

	public function cart_product_list($path,$UserPermission)
	{
	    //select idproducts,product_name,product_feature,cost from 
	    //products where customer_id=1 and product_status='1'  and idproducts not 
	    //in(select idproducts from customer_products where hf_id='119') order by product_sort_order
	    
	    $sess = new Zend_Session_Namespace('user');
	    $hf_id=$sess->hf_id;
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    ->from(array('customer_selected_plan'),array('created_date','plan_status'))
	    ->where('hf_id="'.$hf_id.'"');
	    $plandtd = $db->fetchRow($select);
	   
	  $plandate=$plandtd['created_date'];
	  $currdate=date('Y-m-d');
	  
	
	  $plandate = new Zend_Date($plandate, 'YYYY-MM-dd');
	  $currdate = new Zend_Date($currdate, 'YYYY-MM-dd');
	  
		$daydiff=$currdate->sub($plandate)->toString(Zend_Date::DAY);
	   
	   
	   
	    if($daydiff==0)
	    {
	      
	    	return "equal";
	    	exit;
	    }
	    
	    
	    $customerId = new Zend_Session_Namespace('customerId');
	   	$cusid= $customerId->customerId;
	    $output='';
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $select = $db->select()
	    ->from(array('customer_selected_plan'),array('provider_no'))
	    ->where('hf_id="'.$hf_id.'"');
	  	$providerno = $db->fetchOne($select);

	    $row = $db->query("CALL cart_products($hf_id,$cusid)"); // Its a procedure call
	    $ProductList = $row->fetchAll();
	    
	    $sino=1;
	    $currency = new Zend_Currency('en_US');
	    
	    foreach($ProductList as $PL)
	    {
	        
	        /*
	         * Generating the table list
	         */
	        $output.=' <tr>
    <td height="25" class="normal-text shadowlight">'.$sino.'.</td>
    <td class="normal-text shadowlight">'.$PL['category'].'</td>
    <td class="normal-text shadowlight" nowrap><a class="openmodalbox" href="javascript:void(0);"	rel="ajax: '.$path.'/user/Products/productfeature/id/'.base64_encode($PL['idproducts']).'">'.$PL['product_name'].'</a></td>
    <td align="right" class="normal-text shadowlight">'.$currency->toCurrency($PL['cost']).'</td>
    <td align="right" class="normal-text shadowlight">'.$currency->toCurrency($PL['setup_fee']).'</td>';

    $output.='</td><td align="center" class="normal-text shadowlight">';
             
   
    
            $output.= $providerno.'<td align="center" class="normal-text shadowlight">';
    
   
    /*if($ProductCost)
    {
        $output .='<select name="'.$PL['idproducts'].'">';
        $j=1;
        foreach($ProductCost as $PC)
    	{    
    	    if($j==1)
    	        $output .= '<option value="'.$PC['idproduct_feature'].'">".$providerno Provider</option>';
    	    
			$output .= '<option value="'.$PC['idproduct_feature'].'">'.$PC['user_from'].'-'.$PC['user_to'].' ('.$currency->toCurrency($PC['cost']).')</option>';
			$j += 1;
    	}
      
        $output .= '</select>';
    }
    else 
    {*/
        $output .=$currency->toCurrency(($PL['cost']*$providerno)+$PL['setup_fee']).'<input type="hidden" name="'.$PL['idproducts'].'" value="'.$providerno.'" >';
    //}
     $output .=' </td>';
     
   
     
      if($UserPermission)
      {
    $output .= '<td align="center" class="normal-text shadowlight">
     <input type="checkbox" name="'.$PL['idproducts'].'_cart" id="'.$PL['idproducts'].'_cart" />';
    //<a class="openmodalbox" href="javascript:void(0);"	rel="ajax: '.$path.'/user/Products/addtocart/id/'.base64_encode($PL['idproducts']).'">
    //<img src="'.$path.'/images/add_cart.png" width="16" height="16" title="Add to Cart" alt="Add to Cart" />
    //</a>
    $output .='</td>';
      }
  $output .='</tr>';
	  	//print_r($ProductCost);
     $sino = $sino + 1;
	    }
	    
	    
	    
	   // die;
	    return $output;
	    
	}
	public function viewProducts($id)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $row = $db->query("CALL product_description($id)"); // Its a procedure call
	    return $row->fetchAll();
	}
	public function productaddtocart($id,$providerno)
	{
	  //  echo "hi";
	    $sess = new Zend_Session_Namespace('user');
	    $hf_id=$sess->hf_id;
	    $sesid=session_id();
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	   // echo $id;
	    //echo "<br>";
	    //echo $providerno;
	    //echo "<br>";
	    //echo $sesid;
	    //echo "<br>";
	    //echo $hf_id;
	   // die;
	   
	    // Checking the category of product adding
	    
	    //0:not increment with provider number ; 1: increment with provider number (provider_cost_nature,provider_setup_nature)
	     $sql = "select category,cost,setup_fee,provider_cost_nature,provider_setup_nature from products where idproducts=".$id;
	    $proresult = $db->fetchRow($sql);
	    
	    /*
	     * if category is support, then deleting the existing support product from the selected plan and
	     * adding the new support plan
	     */
	    if($proresult['category']=='support')
	    {
	        $sql = 'select idproducts,cost,setup_fee,provider_cost_nature,provider_setup_nature,additional from customer_products where category="support" and hf_id='.$hf_id;
	        
	        $ExProdtd = $db->fetchRow($sql);
	        
	       //echo "<pre>";
	       //print_r($ExProdtd);
	       //echo "</pre>";
	       //die;
	        if($ExProdtd['additional']==0)
	        {
	            
		        /*
		         * Collecting the support product cost to reduce it from plan
		         */
		        if($ExProdtd['provider_cost_nature']==1)
		        {
		            $deduct_cost = $ExProdtd['cost']*$providerno;
		        }
		        else
		        {
		            $deduct_cost = $ExProdtd['cost'];
		        }
		        if($ExProdtd['provider_setup_nature']==1)
		        {
		            $deduct_setup_cost = $ExProdtd['setup_fee']*$providerno;
		        }
		        else
		        {
		            $deduct_setup_cost = $ExProdtd['setup_fee'];
		        }
		        $sql ='select monthly_payment,setupfee,total_payment from customer_selected_plan where hf_id='.$hf_id;
		        $plancosts = $db->fetchRow($sql);
		        
		        $updated_cost = $plancosts['monthly_payment'] - $deduct_cost;
		        $updated_setup_fee = $plancosts['setupfee'] - $deduct_setup_cost;
		        $updated_total_payment = $updated_cost + $updated_setup_fee;
		        
		       $sql = 'update customer_selected_plan set monthly_payment='.$updated_cost.',setupfee='.$deduct_setup_cost.',total_payment='.$updated_total_payment.' where hf_id='.$hf_id;
		       $db->query($sql);
		       /*
		        * update cart price
		        */
		       
		       $sess = new Zend_Session_Namespace('user');
		       $hf_id = $sess->hf_id;
		       
		       $sql ='select unit_price,setupfee,discount,total from cart where cartsession="'.$sesid.'" and plan_id <>0 and hf_id='.$hf_id.' and cstatus=0';
		       $ExtCartDtd = $db->fetchRow($sql);
		       
		       $NewCartUnitPrice = $ExtCartDtd['unit_price']-$deduct_cost ;
		       $NewCartSetupFee = $ExtCartDtd['setupfee']-$deduct_setup_cost;
		       $newCartTotal = $NewCartUnitPrice + $NewCartSetupFee - $ExtCartDtd['discount'];
		       
		       $sql ='update cart set unit_price='.$NewCartUnitPrice.',setupfee='.$NewCartSetupFee.',total='.$newCartTotal.' where cartsession="'.$sesid.'" and plan_id <>0 and hf_id='.$hf_id.' and cstatus=0';
			   $db->query($sql);		       
		       
		       
		        
	        }
	        
	        $sql ='delete from customer_products where hf_id='.$hf_id.' and category="support" and additional=0';
	       	$db->query($sql);
	    }
	    
	    
	    
	    $row = $db->query("CALL add_product($id,$providerno,'$sesid',$hf_id)"); // Its a procedure call
	    $row = $db->query("SELECT @result"); // Its a procedure call
	    $rst = $row->fetchAll();
		
	    //print_r($rst);
	    foreach($rst as $rs){
	    	return $rs['@result'];    
	    }
	}
	public function CustomePriceAddToCart($pid,$pcostid)
	{
	   // echo $pid;
	   // echo "<br>";
	   // echo $pcostid;
	    
	    
	    $sess = new Zend_Session_Namespace('user');
	    $hf_id=$sess->hf_id;
	    $sesid=session_id();
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $row = $db->query("CALL add_custome_price_product($pid,$pcostid,'$sesid',$hf_id,@result)"); // Its a procedure call
	    $row = $db->query("SELECT @result"); // Its a procedure call
	    $rst = $row->fetchAll();
	    
	    //print_r($rst);
	    foreach($rst as $rs){
	    	return $rs['@result'];
	    }
	    
	    
	}

}

