<?php

class Admin_Model_DbTable_Faq extends Zend_Db_Table_Abstract
{

    protected $_name = 'faq';

	public function listfaq()
	{
	    $customerId = new Zend_Session_Namespace('customerId');
	    $cust_id=$customerId->customerId;
	    $db = Zend_Db_Table::getDefaultAdapter();
	    $sql ='select faqid,category,question,answer,listing_order,status from faq where customer_id='.$cust_id;
	    return $db->fetchAll($sql);
	}
	public function viewfaq($faqid)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		$sql = 'select faqid,category,question,answer,listing_order,status from faq where faqid='.$faqid;
		return $db->fetchRow($sql);
	}
	public function addfaq($formData)
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $customerId = new Zend_Session_Namespace('customerId');
	    $category = addslashes($formData['category']);
	    $question = addslashes($formData['question']);
	    $answer = addslashes($formData['answer']);
	    $listing_order = addslashes($formData['listing_order']);
	    $status = addslashes($formData['status']);
	    
	    
	    $data = array(
	    		'customer_id'=>$customerId->customerId,
	    		'category' => $category,
	    		'question' => $question,
	    		'answer' => $answer,
	    		'listing_order'=>$listing_order,
	    		'status'=>$status
	    );
	    $numRows = $db->insert('faq', $data);
	    
	}
	
	public function updatefaq($formData)
	{
		$db = Zend_Db_Table::getDefaultAdapter();
		
		
		$customerId = new Zend_Session_Namespace('customerId');
		$faqid = addslashes($formData['faqid']);
		$category = addslashes($formData['category']);
		$question = addslashes($formData['question']);
		$answer = addslashes($formData['answer']);
		$listing_order = addslashes($formData['listing_order']);
		$status = addslashes($formData['status']);
		 
		 
		$sql ='update faq set category="'.$category.'",question="'.$question.'",answer="'.$answer.'",listing_order="'.$listing_order.'",status="'.$status.'" where faqid='.$faqid.'';
        $db->query($sql);
		 
	}
	public function deletefaq($faqid)
	{
	    $this->delete('faqid='.$faqid);
	}
}

