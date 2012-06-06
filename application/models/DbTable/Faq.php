<?php

class Application_Model_DbTable_Faq extends Zend_Db_Table_Abstract
{

    protected $_name = 'faq';

	public function listfaq()
	{
	    $db = Zend_Db_Table::getDefaultAdapter();
	    
	    $customerId = new Zend_Session_Namespace('customerId');
	    $cusid = $customerId->customerId;
	    
	    $sess = new Zend_Session_Namespace('user');
	    $userid = $sess->duser;
	    
	    if($userid=='') // General FAQ
	    {
	        $sql = 'select faqid,question,answer from faq where customer_id='.$cusid.' and category=0 and status=1 order by listing_order';
	    }
	    else // User FAQ
	    {
	        $sql = 'select faqid,question,answer from faq where customer_id='.$cusid.' and category=1  and status=1 order by listing_order';
	    }
	    
	    return $db->fetchAll($sql);
	}
}

