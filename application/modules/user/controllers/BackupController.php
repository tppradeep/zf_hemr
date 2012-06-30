<?php

class User_BackupController extends Zend_Controller_Action
{

    public function init()
    {
        /* Initialize action controller here */
        $this->view->checkacl('0','0','0','1'); // Just for initiallization for helper call
        $this->view->checkaclresource('0','0',0); // Just for initiallization for helper call
        $sess = new Zend_Session_Namespace('user');
        if($sess->duser=="")
        {
        	$this->_redirect('Index');
        	exit;
        }
    }

    public function indexAction()
    {
  
	   $credentials = '';
	   $server_page='server_side.php';
	   $parameter_array=array();
	   
	   $sess = new Zend_Session_Namespace('user');
	  // $hf_identifier =  $sess->hf_identifier;
	  
	   $hf_identifier = 'ansera';
	   $parameter_array[]='ansera';
	 //  getFile($hf_identifier,'filename');
	   
	   array_unshift($parameter_array,$credentials);
	   
	   $client = new SoapClient(null, array(
	      'location' => "http://23.21.226.186/backup_server/$server_page",
	      'uri'      => "urn://backup/req"));
	  
	   $json = json_decode($client->getBackUps($parameter_array));
	   $this->view->list = $json;
	
		//die;
	   /*
	   try
	   {
	      
	   		echo $json = $client->getBackUps($parameter_array);
	   		
	   		
	    	//return $json;
	   }
	   catch(Zend_Exception $e)
	   {
	      	echo "Message:".$e->getMessage()."File:".$e->getFile()."Line:".$e->getLine()."---".date("Ymd H:i:s");
	   }
	   */
    }

    public function retrieveFileAction()
    {
        
        
      $filename=$this->view->Dcode($this->_getParam('id'));
      
       $credentials = '';
	   $server_page='server_side.php';
	   $parameter_array=array();
	   
	   $sess = new Zend_Session_Namespace('user');
	  // $hf_identifier =  $sess->hf_identifier;
	  
	   $hf_identifier = 'ansera';
	   $parameter_array[0]='ansera';
	   $parameter_array[1]=$filename;
	   

	   array_unshift($parameter_array,$credentials);
	   
	   $client = new SoapClient(null, array(
	      'location' => "http://23.21.226.186/backup_server/$server_page",
	      'uri'      => "urn://backup/req"));
	  
	   $json = json_decode($client->getFile($parameter_array));
	   
	   echo "<pre>";
	   print_r($json);
	   echo "</pre>";
	           
	 //  $this->view->list = $json;
	
    }


}



