<?php

class Application_Model_DbTable_Cart extends Zend_Db_Table_Abstract
{

    protected $_name = 'customer_products';

    public function username($uid)
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $select = $db->select()
        ->from(array('hosted_facilities'),array('hf_facility_name','hf_email'))
        -> where('hf_id='.$uid);
       return $row=$db->fetchrow($select);
    }
    public function planname($uid,$pid)
    {
        $db = Zend_Db_Table::getDefaultAdapter();
        $select = $db->select()
        -> from(array('customer_selected_plan'),array('plan_name'))
        -> where('hf_id='.$uid)
        -> where("plan_id=".$pid);
        return $row=$db->fetchOne($select);
    }
   	public function cart($uid,$pid)
   	{
   	    $db = Zend_Db_Table::getDefaultAdapter();
   	    $select = $db->select()
   	    -> from(array('cart'),array('idcart','plan_id','description','qty','unit_price','setupfee','discount','setupfee_discount'))
   	    -> where('hf_id='.$uid)
   	    -> where('invoice_no is null')
   	    -> where('cartsession="'.session_id().'"');
   	     
   	    return $row = $db->fetchAll($select);
   	}
	public function activatefreeplan($pid,$sessid,$hf_id)
	{
	      
	    $db = Zend_Db_Table::getDefaultAdapter();
	    /*
	     * ::: STEP 1 : UPDATING STATUS OF CUSTOMER_SELECTED_PLAN :::::::::::::::
	     */
	    $row = $db->query("CALL activatefreeplan($pid,'$sessid',$hf_id)");
	   
	}
	
	public function cart_product_list($path)
	{
		//select idproducts,product_name,product_feature,cost,payment_term from
		//products where customer_id=1 and product_status='1'  and idproducts not
		//in(select idproducts from customer_products where hf_id='119') order by product_sort_order
		 
		$sess = new Zend_Session_Namespace('user');
		$hf_id=$sess->hf_id;
		 
		$db = Zend_Db_Table::getDefaultAdapter();
		
		 
		$customerId = new Zend_Session_Namespace('customerId');
		$cusid= $customerId->customerId;
		$output='';
		$db = Zend_Db_Table::getDefaultAdapter();
		 
		$select = $db->select()
		->from(array('customer_selected_plan'),array('provider_no'))
		->where('hf_id="'.$hf_id.'"');
		$providerno = $db->fetchOne($select);
	
		//select distinct(product_id),idproducts from cart,customer_products where cart.hf_id=78;
 		$select = $db->select()
	    -> from(array('c'=>'cart'),array('distinct(c.product_id)','p.idproducts'))
	    ->join(array('p'=>'customer_products'),'c.hf_id=p.hf_id')
	    -> where('c.hf_id='.$hf_id);
	    
	    $row = $db->fetchAll($select);
	    $SelectedProductList = array();
	    foreach($row as $r)
	    {
	        $SelectedProductList[]=$r["product_id"];
	        $SelectedProductList[]=$r["idproducts"];
	    }
		//echo "<pre>";
	//	print_r($SelectedProductList);
		$SelProList = implode("','", $SelectedProductList);
		$SelProList = "'".$SelProList."'";
	//	die;
		
		
		
	//	SELECT idproducts,product_name,product_feature,cost,setup_fee,payment_term FROM products WHERE
	//	customer_id=cusid AND product_status='1'  AND idproducts NOT IN(cusid) ORDER BY product_sort_order;
	
		
		$select = $db->select()
		-> from(array('products'),array('idproducts','product_name','product_feature','cost','setup_fee','payment_term'))
		-> where('customer_id='.$cusid)
		-> where('idproducts Not In ('.$SelProList.')');
		
		
		
	//	$row = $db->query("CALL cart_additional_products('$hf_id','$cusid','$SelProList')"); // Its a procedure call
		$ProductList = $db->fetchAll($select);
		 
		$sino=1;
		$currency = new Zend_Currency('en_US');

	//	echo "<pre>";
	//	print_r($ProductList);
		foreach($ProductList as $PL)
		{
			 
			/*
			 * Generating the table list
			*/
			$output.=' <tr>
			<td height="25" class="normal-text shadowlight">'.$sino.'.</td>
			<td class="normal-text shadowlight">'.$PL['product_name'].'</td>
			<td align="right" class="normal-text shadowlight">'.$currency->toCurrency($PL['cost']).'</td>
			<td align="right" class="normal-text shadowlight">'.$currency->toCurrency($PL['setup_fee']).'</td>';
		/*	<td align="center" class="normal-text shadowlight">';
			if($PL['payment_term']==0)
			{
				$output.="One Time";
			}
			else {
				$output.="Monthly";
			}
			</td>;
			*/
			$output.='<td align="center" class="normal-text shadowlight">
			<a class="openmodalbox" href="javascript:void(0);"	rel="ajax: '.$path.'/user/Products/productfeature/id/'.base64_encode($PL['idproducts']).'">
			<img src="'.$path.'/images/expand.png" width="16" height="16" title="View Features" alt="View Features" />
			</a>
			</td>
			<td align="center" class="normal-text shadowlight">';
	
			$PLID=$PL['idproducts'];
			$row2 = $db->query("CALL product_cost($PLID)"); // Its a procedure call
			$ProductCost = $row2->fetchAll();
			
			$output .=$providerno.'<input type="hidden" name="'.$PL['idproducts'].'" value="'.$providerno.'" >';
			
			$output .=' </td>
			<td align="center" class="normal-text shadowlight">';
			$output .= $currency->toCurrency(($PL['cost']*$providerno)+$PL['setup_fee']);
			$output .='</td>
			<td align="center" class="normal-text shadowlight">
			<input type="checkbox" name="'.$PL['idproducts'].'_cart" id="'.$PL['idproducts'].'_cart" onclick="AddAdditionalProductIntoCart('.$PL['idproducts'].','.$providerno.',this.checked)" />';
			//<a class="openmodalbox" href="javascript:void(0);"	rel="ajax: '.$path.'/user/Products/addtocart/id/'.base64_encode($PL['idproducts']).'">
			//<img src="'.$path.'/images/add_cart.png" width="16" height="16" title="Add to Cart" alt="Add to Cart" />
			//</a>
			$output .='</td>
			</tr>';
			//print_r($ProductCost);
			$sino = $sino + 1;
		}
		 
		 
		// die;
		return $output;
		 
	}
	function deleteproductfromcart($idcart)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->delete('cart',array('idcart='.$idcart));
	}
}

