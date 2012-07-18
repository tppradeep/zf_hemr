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
	    $SupportCost = 0;
	    foreach($row as $r)
	    {
	        $SelectedProductList[]=$r["product_id"];
	        $SelectedProductList[]=$r["idproducts"];
	        
	        if($r['category']=='support')
	        {
	            $SupportCost = $r['cost'];
	        }
	    }
	    
	    /*
	     * Remove the support product, which cost is less then selected plan
	     */
	    
	   	$sql = 'select idproducts from products where category="support" and cost <= '.$SupportCost.' and customer_id='.$cusid;
	    
	    $Prolist = $db->fetchAll($sql);
	    

	    $ExistProId = array();
	    foreach($Prolist as $pr)
	    {
	        $ExistProId[]=$pr['idproducts'];
	    }

	  
	    
	    $ExistProIdList = implode("','", $ExistProId);
	    
	    $ExistProIdList = "'".$ExistProIdList."'";
	   
		$SelProList = implode("','", $SelectedProductList);
		$SelProList = "'".$SelProList."'";
		
		$SelProList = $SelProList.','.$ExistProIdList;
		
		$sql = 'select idproducts,category,product_name,product_feature,cost,setup_fee from products where customer_id='.$cusid.' and idproducts Not In ('.$SelProList.') order by category,product_name';
		$ProductList = $db->fetchAll($sql);
		 
		$sino=1;
		$currency = new Zend_Currency('en_US');

		foreach($ProductList as $PL)
		{
			 
			/*
			 * Generating the table list
			*/
			$output.=' <tr>
			<td height="25" class="normal-text shadowlight">'.$sino.'.</td>
			        <td height="25" class="normal-text shadowlight">'.$PL['category'].'</td>
			<td class="normal-text shadowlight" nowrap="nowrap"><a class="openmodalbox" href="javascript:void(0);"	rel="ajax: '.$path.'/user/Products/productfeature/id/'.base64_encode($PL['idproducts']).'">'.$PL['product_name'].'</a></td>
			<td align="right" class="normal-text shadowlight">'.$currency->toCurrency(round($PL['cost'])).'</td>
			<td align="right" class="normal-text shadowlight">'.$currency->toCurrency(round($PL['setup_fee'])).'</td>';
			$output.='<td align="center" class="normal-text shadowlight">';
	
			$PLID=$PL['idproducts'];
			$row2 = $db->query("CALL product_cost($PLID)"); // Its a procedure call
			$ProductCost = $row2->fetchAll();
			
			$output .=$providerno.'<input type="hidden" name="'.$PL['idproducts'].'" value="'.$providerno.'" >';
			
			$output .=' </td>
			<td align="right" class="normal-text shadowlight">';
			$output .= $currency->toCurrency(round($PL['cost']*$providerno)+$PL['setup_fee']);
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
	    
	    /*
	     * Only additional product can add or delete so product id requried to calculate from cart id
	     */
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $sql = 'select product_id,hf_id,qty from cart where idcart='.$idcart;
	    $pdetails = $db->fetchRow($sql);
	    
	 //   echo "<pre>";
	  //  print_r($pdetails);
	  //  echo "</pre>";
	   // die;
	    $sql ='select provider_no from customer_selected_plan where hf_id='.$pdetails['hf_id'];
	    $providerno = $db->fetchOne($sql);
	    
	    
	    $select = $db->delete('cart',array('idcart='.$idcart));
	    
	    $sql = 'delete from customer_products where hf_id='.$pdetails['hf_id'].' and idproducts='.$pdetails['product_id'];
	    $db->query($sql);
	    
	    /*
	     * Deleted the selected product from cart and customer_product
	     * Now checking is there any support product is in plan. if not fetching the basic plan support product and adding to plan
	     */
	    
	    $sql ='select count(idcustomer_products) as idcount from customer_products where hf_id='.$pdetails['hf_id'].' and category="support"';
	    $idcount = $db->fetchOne($sql);
	    
	    if($idcount==0)
	    {
	        $sql='select distinct(hp_id) from customer_products where hp_id<>0 and hf_id='.$pdetails['hf_id'];
	        $planid = $db->fetchOne($sql);
	        
	        $sql = 'select p.* from plan_products pp,products p where pp.idplan='.$planid.' and pp.idproducts=p.idproducts and p.category="support"';
	        $a_p_d = $db->fetchRow($sql);
	        
	        $sql = 'insert into customer_products (hf_id,hp_id,idproducts,category,product_name,customer_id,product_feature,cost,setup_fee,product_sort_order,product_status,ProductType,provider_cost_nature,provider_setup_nature,emrfeature,additional)';
	        $sql =$sql.' values ('.$pdetails['hf_id'].','.$planid.','.$a_p_d['idproducts'].',"'.$a_p_d['category'].'","'.$a_p_d['product_name'].'",'.$a_p_d['customer_id'].',"'.$a_p_d['product_feature'].'",'.$a_p_d['cost'].','.$a_p_d['setup_fee'].','.$a_p_d['product_sort_order'].','.$a_p_d['product_status'].','.$a_p_d['ProductType'].','.$a_p_d['provider_cost_nature'].','.$a_p_d['provider_setup_nature'].','.$a_p_d['emrfeature'].',0)';
	        
			$db->query($sql);
			
			/*
			 * updating cost of plan
			 */
			if($a_p_d['provider_cost_nature']==1)
			{
				$deduct_cost = $a_p_d['cost']*$providerno;
			}
			else
			{
				$deduct_cost = $a_p_d['cost'];
			}
			if($a_p_d['provider_setup_nature']==1)
			{
				$deduct_setup_cost = $a_p_d['setup_fee']*$providerno;
			}
			else
			{
				$deduct_setup_cost = $a_p_d['setup_fee'];
			}
			
			
			//echo $deduct_cost;
			//die;
			$sql ='select monthly_payment,setupfee,total_payment from customer_selected_plan where hf_id='.$pdetails['hf_id'];
			$plancosts = $db->fetchRow($sql);
			
			$updated_cost = $plancosts['monthly_payment'] + $deduct_cost;
			$updated_setup_fee = $plancosts['setupfee'] + $deduct_setup_cost;
			$updated_total_payment = $updated_cost + $updated_setup_fee;
			
			$sql = 'update customer_selected_plan set monthly_payment='.$updated_cost.',setupfee='.$deduct_setup_cost.',total_payment='.$updated_total_payment.' where hf_id='.$pdetails['hf_id'];
			$db->query($sql);
			
			/*
			 * update cart price
			*/
			 
			$sesid=Session_id();
			$sess = new Zend_Session_Namespace('user');
			$hf_id = $sess->hf_id;
			 
			$sql ='select unit_price,setupfee,discount,total from cart where cartsession="'.$sesid.'" and plan_id <>0 and hf_id='.$hf_id.' and cstatus=0';
			$ExtCartDtd = $db->fetchRow($sql);
			 
			$NewCartUnitPrice = $ExtCartDtd['unit_price']+$deduct_cost ;
			$NewCartSetupFee = $ExtCartDtd['setupfee']+$deduct_setup_cost;
			$newCartTotal = $NewCartUnitPrice + $NewCartSetupFee - $ExtCartDtd['discount'];
			 
			$sql ='update cart set unit_price='.$NewCartUnitPrice.',setupfee='.$NewCartSetupFee.',total='.$newCartTotal.' where cartsession="'.$sesid.'" and plan_id <>0 and hf_id='.$hf_id.' and cstatus=0';
			$db->query($sql);
			
	    }
	    
	}
}

