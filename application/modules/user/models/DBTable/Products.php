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
    <td class="normal-text shadowlight">'.$PL['product_name'].'</td>
    <td align="right" class="normal-text shadowlight">'.$currency->toCurrency($PL['cost']).'</td>
    <td align="right" class="normal-text shadowlight">'.$currency->toCurrency($PL['setup_fee']).'</td>
     <td align="center" class="normal-text shadowlight"> <a class="openmodalbox" href="javascript:void(0);"	rel="ajax: '.$path.'/user/Products/productfeature/id/'.base64_encode($PL['idproducts']).'">
      <img src="'.$path.'/images/expand.png" width="16" height="16" title="View Features" alt="View Features" />
      </a></td>';

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

