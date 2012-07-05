<div id="header">
  <?php
$sess = new Zend_Session_Namespace('user');

if(!$sess->duser=="")
{
    if($sess->dashboard==1)
    {
?>
  <a href="<?php echo $this->url(array('controller'=>'user','action'=>'index'),null,true);?>" class="header-home-logo"><img src="<?php echo $this->baseUrl();?>/images/home.png" alt="Home" /></a>
  <?php 
    }
?>
  <a href="<?php echo $this->url(array('controller'=>'Index','action'=>'logout'),null,true);?>" class="header-home-logo"><img src="<?php echo $this->baseUrl();?>/images/logout_home.png" alt="Logout" title="Logout" /></a>
  <?php
}
else
{
?>
  <a href="<?php echo $this->url(array('controller'=>'Index','action'=>'index'),null,true);?>" class="header-home-logo"><img src="<?php echo $this->baseUrl();?>/images/home.png" alt="Home" /></a>
  <?php
}
?>
</div>
