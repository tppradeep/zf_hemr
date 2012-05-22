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
	    -> from(array('p'=>'products'),array('p.idproducts','p.product_name','p.product_feature','p.cost','p.setup_fee','p.payment_term','provider_cost_nature','provider_setup_nature'))
	    ->join(array('pp'=>'plan_products'),'pp.idproducts=p.idproducts')
	    -> where('pp.idplan='.$pid);
	    
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

	    $output='';
	    foreach($row as $plandtd)
	    {
	        $output .=" <td valign='top'><div class='table-head white shadow'>".$plandtd['hp_name']."</div>";
	        $output .=" <table width='100%' border='0' cellspacing='2' cellpadding='2'>
	        	        <tr>
	        			<td width='3%' align='center' class='product-head shadow'>#</td>
	        			<td width='73%' class='product-head shadow'>Package Includes</td>
	        			<td width='24%' align='right' class='product-head shadow'>Cost</td>
	        			</tr>";
	        
	        $plancost=0;
	        $sino=1;
	        
	        $product_sql = $db->select()
	         -> from(array('p'=>'products'),array('p.idproducts','p.product_name','p.product_feature','p.cost','p.payment_term'))
	  		 ->join(array('pp'=>'plan_products'),'pp.idproducts=p.idproducts')
	    	 -> where('pp.idplan='.$plandtd['hp_id']);

	        $productrow = $db->fetchAll($product_sql);
	        
	        foreach($productrow as $productdtd)
	        {
	        	$output .=' <tr>
	        				<td align="center" valign="top" class="normal-text shadowlight">'.$sino.'.</td>
      						<td class="normal-text shadowlight"><span class="product">'.$productdtd['product_name'];
	        	if($productdtd['payment_term']==1)
	        	{
	        		$output .= "(Monthly Payment)";
	        	}

	        	$output .='</span><br />
        					<strong>Features : </strong>
        					<p>'.$productdtd['product_feature'].'</p></td>
      						<td align="right" valign="top" class="normal-text shadowlight">$ '.$productdtd['cost'].'</td>
    						</tr>';
	        	
	        	if($productdtd['cost']=="")
	        		$productdtd['cost']=0;
	        	$plancost = $plancost + $productdtd['cost'];
	        	$sino = $sino + 1;
	        	
	        }
	        	$output .=' <tr>
      						<td class="product-head shadowlight" colspan="2">Plan Amount :</td>
      						<td align="right" valign="top" class="product-head shadowlight">$ '.$plancost.'</td>
    						</tr>
     						<tr>
      						<td colspan="3" align="right" valign="top">
        					<a href="../UserRegister/adduser/id/'.base64_encode($plandtd['hp_id']).'" class="plan-register">Proceed To Registration</a></td>
    						</tr>
  							</table>
	        	
	        				</td>';
	    }
	    
	    return $output;
	}
	
}
?>

