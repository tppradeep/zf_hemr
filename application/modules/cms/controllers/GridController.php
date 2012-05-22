<?php
require 'cms/models/Project.php';

class Cms_GridController extends Zend_Controller_Action
{
	public function init()
	{
		$this->view->baseUrl = $this->_request->getBaseUrl();
		$this->view->addScriptPath(Core::getBaseDir() . DIRECTORY_SEPARATOR . 'skins/scripts/datagrid/');
	}

	public function indexAction()
	{
		$this->_forward('test4');
	}

	public function testAction()
	{	
		$grid = new Core_DataGrid(new Core_DataGrid_DataSource_Table(new Project()), 5);
		
		$grid->setDefaultSort('title')
    	->setDefaultDir("asc");
		
		$this->view->grid = $grid;
	}
	
	public function test1Action()
	{
		$grid = new Core_DataGrid(new Core_DataGrid_DataSource_Table(new Project()), 5);

    	$grid->setDefaultSort('title')
    	->setDefaultDir("asc");
		
		$titulo = new Core_DataGrid_Column('link', 'Title', null , 'left');
		$titulo->setLinks($this->view->baseUrl . '/cms/grid/view/id/$id/');
		
		$grid->addColumn('title', $titulo);

		$grid->addColumn('description', new Core_DataGrid_Column('text', 'Description', null , 'left'));
		
        $grid->addColumn('updated_at', new Core_DataGrid_Column('text', 'Last Modified', 180));

		$grid->addColumn('is_active', array(
            'header'=>'Status',
		    'width'=>80,
            'type' => 'options',
            'options' => array(0 => 'Disabled', 1 => 'Enabled')));

		$grid->addColumn('preview', array(
            'header'    =>'Preview',
            'width'     =>10,
            'sortable'  => false,
		    'align' =>'center',
            'type' => 'action',
            'actions' => array(
                    'url' => $this->view->baseUrl . '/cms/grid/view/id/$id/',
                    'caption' => 'Preview',
                    'target' => '_blank',
					'image' => $this->view->baseUrl . '/public/images/view.gif')));
		
		$grid->addColumn('edit', array(
            'header'    =>'Edit',
            'width'     =>10,
			'style'=>'text-align: center',
            'sortable'  => false,
            'type' => 'action',
            'actions' => array(
                    'url' => $this->view->baseUrl . '/cms/grid/edit/id/$id/',
                    'caption' => 'Edit',
					'image' => $this->view->baseUrl . '/public/images/edit.png')));
		 
		$grid->addColumn('delete', array(
            'header'    => 'Delete',
            'width'     => 10,
			'style'=>'text-align: center',
            'sortable'  => false,
            'type' => 'action',
            'actions' => array(
                    'url' => $this->view->baseUrl . '/cms/grid/delete/id/$id/',
                	'confirm' => '¿Are you sure you want to delete $title ($id)?',
                    'caption' => 'Delete',
					'image' => $this->view->baseUrl . '/public/images/delete.png')));
		
		$this->view->grid = $grid;
		$this->render('test');
	}
	
	public function test2Action()
	{
		$grid = new Core_DataGrid(new Core_DataGrid_DataSource_DbSelect(), 5);
		$grid->setDefaultSort('title')
    	->setDefaultDir("asc");
		
		$select = $grid->getSelect()->from('project', array('id', 'title', 'description', 'address', 'sale_office' , 'created_at'));
		$this->view->grid = $grid;
		$this->render('test');
	}
	
	public function test3Action()
	{	
		$projctModel = new Project();
		
		$projectArray = $projctModel->fetchAll()->toArray();

		$grid = new Core_DataGrid(null, 6);

		$grid->setDefaultSort(array('id' => "desc"))
		->bindDataSource(new Core_DataGrid_DataSource_Array($projectArray));

		$this->view->grid = $grid;
		$this->render('test');
	}
	
	public function test4Action()
	{
		$projctModel = new Project();
		$projectArray = $projctModel->fetchAll()->toArray();

		$grid = new Core_DataGrid(new Core_DataGrid_DataSource_Array($projectArray), 6);

		$grid->setDefaultSort('title')
		     ->setDefaultDir("asc");

		$this->view->grid = $grid;
		$this->render('test');

	}
	
	public function test5Action()
	{
		$grid = new Core_DataGrid(new Core_DataGrid_DataSource_Propel(new Criteria(), 'ProjectPeer', 'doSelect'), 5);
		$grid->setDefaultSort('title')
    	->setDefaultDir("asc");
		
		$this->view->grid = $grid;
		$this->render('test');
	}
}