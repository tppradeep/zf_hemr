<?php
class Application_Model_DbTable_PlanList extends Zend_Db_Table_Abstract
{

   // protected $_name = 'hosted_plans';
	
	public function planname($pid)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		-> from(array('h'=>'hosted_plans'),array('h.hp_name','bundle_discount_type','bundle_discount_per_cost','bundle_discount_per_setup','bundle_cost','bundle_setup_cost'))
		-> where('h.hp_id='.$pid);
		
		$row = $db->fetchRow($select);
		
		if (!$row)
		{
			throw new Exception("Could not find row");
		}
		return $row;
	}
	
	public function productdetails($pid)
	{
	    //select p.idproducts,p.product_name,p.product_feature,p.cost,p.payment_term from products p, plan_products pp where pp.idproducts=p.idproducts and pp.idplan=1
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    -> from(array('p'=>'products'),array('p.idproducts','p.product_name','p.product_feature','p.cost','p.setup_fee','provider_cost_nature','provider_setup_nature'))
	    ->join(array('pp'=>'plan_products'),'pp.idproducts=p.idproducts')
	    -> where('pp.idplan='.$pid);
	    
	    $row = $db->fetchAll($select);
	    
	    if (!$row)
	    {
	    	throw new Exception("Could not find row");
	    }
	    return $row;
	}
	
	public function productdetails_cart($pid,$hf_id)
	{
		//select p.idproducts,p.product_name,p.product_feature,p.cost,p.payment_term from products p, plan_products pp where pp.idproducts=p.idproducts and pp.idplan=1
		$db = Zend_Db_Table::getDefaultAdapter();
		$select = $db->select()
		-> from(array('p'=>'customer_products'),array('p.idproducts','p.product_name','p.product_feature','p.cost','p.setup_fee'))
		-> where('p.hf_id='.$hf_id)
		-> where('p.hp_id='.$pid);
		 
		$row = $db->fetchAll($select);
		 
		if (!$row)
		{
			throw new Exception("Could not find row");
		}
		return $row;
	}
	
	public function allplans()
	{
	    /*
	     * This function list all plans with its product information
	     * Dono't change anything below
	     */
	    
	    $customerId = new Zend_Session_Namespace('customerId');
	    $cusid=$customerId->customerId;
	    
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $select = $db->select()
	    -> from(array('hosted_plans'),array('hp_id','hp_name','bundle_cost','bundle_setup_cost'))
	    -> where('customer_id='.$cusid)
	    -> where('hp_status=1')
	    -> order('hp_sortorder');
	     
	    $row = $db->fetchAll($select);
		
	    $planid = array();
	    $planprice = array();
	    $output='';
	    $currency = new Zend_Currency('en_US');
	    $output.="<tr><td valign='top' class='table-head white shadow'>#</td><td valign='top' class='table-head white shadow'>Features</td>";
	    foreach($row as $plandtd)
	    {
	        $output .=" <td valign='top' align='center' class='table-head white shadow'>".$plandtd['hp_name']."";
	        $output .=' </td>';
	        $planid[]=$plandtd['hp_id'];
	        $planprice[] = $plandtd['bundle_cost'];
	    }
	    $output .=' </tr>';
	    
	    $sql = 'select idproducts,product_name from products where ProductType in(1,3) order by product_sort_order asc';
	    $flist = $db->fetchAll($sql);
	    $sino=1;
	    	foreach($flist as $FL)
	    	{
	    	     $output .= '<tr><td class="normal-text shadowlight">'.$sino.'.</td><td class="normal-text shadowlight"><a class="openmodalbox"	href="javascript:void(0);"	rel="ajax: ../Plan-list/product-details/id/'.$FL['idproducts'].'">'.$FL['product_name'].'</a></td>';
	    	    
	    	    /*
	    	     * Checking Query Below
	    	     */
	    	     foreach($planid as $PPL)
	    	     {
		    		$sql='select count(idplanproducts) as id  from plan_products where idplan='.$PPL.' and idproducts='.$FL['idproducts'];	    
					$r1 = $db->fetchOne($sql);
		    		$output .= '<td align=center class=shadowlight>';
		    		if($r1>0)
		    		{
		    		    $output .= "<img src=../images/ok.png>";
		    		    
		    		}
		    		else {
		    		     $output .= "<img src=../images/no.png>";
		    		}
		    		$output .= '</td>';
	    	     }
	    		
	    		$output .= '</tr>';
	    		$sino +=1;
	    	}
	    	// For Price Listing
	    	$currency = new Zend_Currency('en_US');
	    	
	    	
	    	$output .= '<tr><td>&nbsp</td><td>&nbsp</td>';
	    	foreach($planid as $PPL)
	    	{
	    	
	    		$output .= '<td align=center class="normal-text">';
	    		$sql ='call listprice('.$PPL.')';
	    		$listprice =  $db->fetchOne($sql);    		 
	    		$output .= '<span class=strike>List Price : '.$currency->toCurrency($listprice).'</span>';
	    		$output .= '</td>';
	    	}
	    	$output .='</tr>';
	    	$output .= '<tr><td>&nbsp</td><td>&nbsp</td>';
	    	foreach($planprice as $PPL)
	    	{
	    	
	    		$output .= '<td align=center class="normal-text">';
	    		$output .= 'List Price : '.$currency->toCurrency($PPL).'<br/>(Per Provider/Month)';
	    		$output .= '</td>';
	    	}
	    	$output .='</tr>';
	    	// For registration
	    	$output .= '<tr><td>&nbsp</td><td>&nbsp</td>';
	    	
	    	$sess = new Zend_Session_Namespace('user');
	    	
	 		 foreach($planid as $PPL)
	    	     {
		    		
		    		$output .= '<td align=center>';
		    		if($sess->step=="compare")
		    		{
		    		    $output .= '<a href="../PlanList/listplan/id/'.base64_encode($PPL).'" class="plan-register">Select Plan</a>';
		    		}
		    		else 
		    		{
		    			$output .= '<a href="../PlanList/listplan/id/'.base64_encode($PPL).'" class="plan-register">Proceed To Registration</a>';
		    		}
		    		$output .= '</td>';
	    	     }
		$output .='</tr>';	    	
	    return $output;
	}
	
}
?>

