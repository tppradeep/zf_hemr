<?php

class Admin_PlansController extends Zend_Controller_Action
{
    public function generateResourcesAction() {
    	$objResources = new ZH_ACL_Resources();
    	$objResources->buildAllArrays();
    	$objResources->writeToDB();
    }
    public function preDispatch()
    {
    	$auth = Zend_Auth::getInstance();
    	if (!$auth->hasIdentity()) {
    		$this->_redirect('/');
    	} else {
    		$userdata = $auth->getIdentity();
    		$this->user_role = $userdata->role;
    		//$this->view->username = $userdata->username;
    	}
    }
    public function init()
    {
        /*
    	 * This section is using for displaying the status of action
    	 * if st=1 then add success
    	 * if st=2 then update success
    	 * if st=3 then delete success
    	 */
    	$id=$this->_getParam('st');
    	$pss = new Admin_Model_DbTable_Planfeatures();
    	$this->view->pss = $pss->viewStatus($id);
    }

    public function indexAction()
    {
        //***************ACCESS CHECK*************************//
        $acl = Zend_Registry::get('acl');
        if(!$acl->isAllowed($this->user_role, 'Plans')){
        	$this->_redirect('Admin/admin/noaccess');
        }
        //***************END ACCESS CHECK*************************//
        
       
        
        $ps = new Admin_Model_DbTable_Plandb();
    	$this->ps = $ps->plans();
    //	echo "<pre>";
    	$i=0;
    	foreach($this->ps as $plan)
    	{
    	    //print_r($ps->plancost($plan['hp_id']));
    	    $pcost[$i]=$ps->plancost($plan['hp_id']);
    	    
			$i=$i+1;
    	}
    	
    	$this->view->ps=$this->ps;
    	$this->view->pscost=$pcost;
    }

    public function addAction()
    {
     if ($this->getRequest()->isPost()) 
		{
		
			
			$formData = $this->getRequest()->getPost();
		
		
			
				$hp_name = $formData['hp_name'];
				$hp_caption = $formData['hp_caption'];
				$hp_sortorder = $formData['hp_sortorder'];
				$hp_status = $formData['hp_status'];
				$discount=$formData['discount'];
				$discount_start_date = $formData['from'];
				$discount_end_date=$formData['to'];
				$Imagename="default.png";
				
			
				// calling model db to insert values			
				$pfeature = new Admin_Model_DbTable_Plandb();
				$pid=$pfeature->addPlan($hp_name,$hp_caption,$hp_sortorder,$hp_status,$discount,$discount_start_date,$discount_end_date,$Imagename);
				
				
				
				/*
				 * * * * * * * * * * * * * * *
				*   IMAGE UPLOADING SECTION
				* * * * * * * * * * * * * * *
				*/
				$imgwithpath = str_replace("application", "public", APPLICATION_PATH).'\\uploads\\plans\\';
				$upload = new Zend_File_Transfer_Adapter_Http();
				$upload->addValidator('Count', false, array('min' =>1, 'max' => 1))
				->addValidator('IsImage', false, 'jpeg,gif,jpg,png')
				->addValidator('Size', false, array('max' => '5551200kB'))
				->setDestination($imgwithpath);
				if (!$upload->isValid())
				{
					throw new Exception('Bad image data: '.implode(',', $upload->getMessages()));
				}
					
				try {
					$upload->receive();
				}
				catch (Zend_File_Transfer_Exception $e)
				{
					throw new Exception('Bad image data: '.$e->getMessage());
				}
				$Imagename = $upload->getFileName('image_name',false);
					
				$fileext=explode(".", $Imagename);
				
				$fullPathNameFile=$imgwithpath.$Imagename;
				$locationFile=$imgwithpath.$pid.".".$fileext[1];
				rename($fullPathNameFile, $locationFile);
				
					
				require_once 'Zend/Filter/ImageSize.php';
				require_once 'Zend/Filter/ImageSize/Strategy/Crop.php';
					
				//echo $imgwithpath = $imgwithpath.$Imagename;
					
				$filter = new Zend_Filter_ImageSize();
				$output = $filter->setHeight(215)
    			->setWidth(190)
				->setThumnailDirectory($imgwithpath)
				->setOverwriteMode(Zend_Filter_ImageSize::OVERWRITE_ALL)
				->setStrategy(new Zend_Filter_Imagesize_Strategy_Crop())
				->filter($locationFile);
				
				$Imagename=$pid.".".$fileext[1];
				$ppid=$pfeature->addPlanImg($pid,$Imagename);
				
				
				// Delete Original and give name to resize image
							
				unlink($locationFile);

				rename($imgwithpath.$pid."-190x215.".$fileext[1], $locationFile);
				/*
				 * * * * * * * * * * * * * * * *
				*   IMAGE UPLOADING SECTION END
				* * * * * * * * * * * * * * * *
				*/
				$this->_redirect('Admin/Plans/index/st/1');
			}
		
    }

    /**
     * @throws Exception
     */
    public function editAction()
    {
    	$id=$this->view->Dcode($this->_getParam('id')); // Retriving id from query string
    	
    	 $ps = new Admin_Model_DbTable_Plandb();
    	 
    	 $this->view->plancost = $ps->plancost($id);
    	 

    	
    	if ($this->getRequest()->isPost())
    	{
    	
    	
    		$formData = $this->getRequest()->getPost();
    	
    		    	
    		$hp_id = $formData['hp_id'];
    		$hp_name = $formData['hp_name'];
    		$hp_caption = $formData['hp_caption'];
    		$hp_sortorder = $formData['hp_sortorder'];
    		$hp_status = $formData['hp_status'];
//    		$discount=$formData['discount'];
 //   		$discount_start_date = $formData['from'];
  //  		$discount_end_date=$formData['to'];
    		
    		$pcost = $formData['pcost'];
    	 	$psetup = $formData['psetup'];
    		$bundle_discount_type = $formData['bundle_price_type'];
    		$setup_discount = $formData['setup_discount'];
    		$cost_discount = $formData['cost_discount'];
    		
    		if($bundle_discount_type==0) // No discount
    		{
    			$bundle_discount_per_cost=0;
    			$bundle_discount_per_setup=0;
    		
    			$bundle_discount_setup = $psetup;
    			$bundle_discount_cost = $pcost;
    		}
    		if($bundle_discount_type==1) // in %
    		{
    		    $bundle_discount_per_cost=$cost_discount;
    		    $bundle_discount_per_setup=$setup_discount;
    		    
    		    $bundle_discount_setup = $psetup - ($psetup * $bundle_discount_per_setup) / 100;
    		    $bundle_discount_cost = $pcost - ($pcost * $bundle_discount_per_cost) / 100;
    		}
    		if($bundle_discount_type==2) // in amount
    		{
    			$bundle_discount_per_cost=$cost_discount;
    		    $bundle_discount_per_setup=$setup_discount;
    		
    			$bundle_discount_setup = $psetup - $bundle_discount_per_setup;
    			$bundle_discount_cost = $pcost - $bundle_discount_per_cost;
    		}
    		
    	
    		
    		/*
    		 * * * * * * * * * * * * * * *
    		*   IMAGE UPLOADING SECTION
    		* * * * * * * * * * * * * * *
    		*/
    		$imgwithpath = str_replace("application", "public", APPLICATION_PATH).'\\uploads\\plans\\';
    		
    		$upload = new Zend_File_Transfer_Adapter_Http();
    		$upload->addValidator('Count', false, array('min' =>1, 'max' => 1))
    		->addValidator('IsImage', false, 'jpeg,gif,jpg,png')
    		->addValidator('Size', false, array('max' => '5551200kB'))
    		->setDestination($imgwithpath);
    		if (!$upload->isValid())
    		{
    			throw new Exception('Bad image data: '.implode(',', $upload->getMessages()));
    		}
    		 
    		try {
    			$upload->receive();
    		}
    		catch (Zend_File_Transfer_Exception $e)
    		{
    			throw new Exception('Bad image data: '.$e->getMessage());
    		}
    		$Imagename = $upload->getFileName('image_name',false);
			
    		$fileext=explode(".", $Imagename);
    		
    		$fullPathNameFile=$imgwithpath."\\".$Imagename;
    		$locationFile=$imgwithpath."\\".$hp_id.".".$fileext[1];
    		rename($fullPathNameFile, $locationFile);
    		
    		 
    		require_once 'Zend/Filter/ImageSize.php';
    		require_once 'Zend/Filter/ImageSize/Strategy/Crop.php';
    		 
    		//echo $imgwithpath = $imgwithpath.$Imagename;
    		 
    		$filter = new Zend_Filter_ImageSize();
    		$output = $filter->setHeight(215)
    		->setWidth(190)
    		->setThumnailDirectory($imgwithpath)
    		->setOverwriteMode(Zend_Filter_ImageSize::OVERWRITE_ALL)
    		->setStrategy(new Zend_Filter_Imagesize_Strategy_Crop())
    		->filter($locationFile);
    		
    		// Delete Original and give name to resize image
    		unlink($fullPathNameFile);
    		rename($imgwithpath."\\".$hp_id."-190x215.".$fileext[1], $locationFile);
    		
    		/*
    		 * * * * * * * * * * * * * * * *
    		*   IMAGE UPLOADING SECTION END
    		* * * * * * * * * * * * * * * *
    		*/
    		
    		$Imagename=$hp_id.".".$fileext[1];
    		
    		// calling model db to insert values (Planfeatures.php)
    		$pss = new Admin_Model_DbTable_Plandb();
    		$pss->updatePlan($hp_id,$hp_name,$hp_caption,$hp_sortorder,$hp_status,$discount,$discount_start_date,$discount_end_date,$Imagename,$bundle_discount_type,$bundle_discount_per_cost,$bundle_discount_per_setup,$bundle_discount_cost,$bundle_discount_setup);
    		 
    		$this->_redirect('Admin/Plans/index/st/2');
    		 
    	}
    	else 
    	{
        	$planedit = new Admin_Model_DbTable_Plandb(); // initializing the class
        	$this->view->planedit = $planedit->RetrivePlanValues($id); // Calling values to display
    	} 
    }

    public function deleteAction()
    {
        $id=$this->_getParam('id');
        
        // Delete from Plan_products. FK table
              
	   	$pss = new Admin_Model_DbTable_Plandb();
    	$this->view->fvalues = $pss->deletePlans($id);
    	$this->_redirect('Admin/Plans/index/st/3');
    }


}







