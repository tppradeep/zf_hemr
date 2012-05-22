<?php

/**
 *
 * LICENSE
 *
 * This source file is subject to the new BSD license
 * It is  available through the world-wide-web at this URL:
 * http://www.petala-azul.com/bsd.txt
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to geral@petala-azul.com so we can send you a copy immediately.
 *
 * @package    Bvb_Grid
 * @copyright  Copyright (c)  (http://www.petala-azul.com)
 * @license    http://www.petala-azul.com/bsd.txt   New BSD License
 * @version    $Id: Number.php 1732 2011-05-14 22:26:41Z bento.vilas.boas@gmail.com $
 * @author     Bento Vilas Boas <geral@petala-azul.com >
 */

class Bvb_Grid_Filters_Render_Dojo_Number extends Bvb_Grid_Filters_Render_RenderAbstract
{


    /**
     * @see library/Bvb/Grid/Filters/Render/Bvb_Grid_Filters_Render_RenderAbstract::getChilds()
     */
    public function getChilds ()
    {
        return array('from', 'to');
    }


    /**
     * @see library/Bvb/Grid/Filters/Render/Bvb_Grid_Filters_Render_RenderAbstract::normalize()
     */
    public function normalize ($value, $part = '')
    {
        return preg_replace('/\D/','',$value);
    }


    /**
     * Retuns current conditions
     *
     * @return array
     */
    public function getConditions ()
    {
        return array('from' => '>=', 'to' => '<=');
    }


    /**
     * @see library/Bvb/Grid/Filters/Render/Bvb_Grid_Filters_Render_RenderInterface::render()
     */
    public function render ()
    {
        $this->removeAttribute('id');
        
        
        $this->setDefaultValue(preg_replace('/\D/','',$this->getDefaultValue('to')),'to');
        $this->setDefaultValue(preg_replace('/\D/','',$this->getDefaultValue('from')),'from');
        
        $this->setAttribute('dojoType', 'dijit.form.NumberTextBox');
        
        Zend_Dojo::enableView($this->getView());
        $this->getView()->dojo()
             ->enable()
             ->setDjConfigOption('parseOnLoad',true)
             ->requireModule('dijit.form.NumberTextBox');
       
        

        if ( ! $this->hasAttribute('style') ) $this->setAttribute('style', 'width:50px !important;');

        return '<span>' . $this->__('From:') . "</span>" 
               . $this->getView()->formText($this->getFieldName() . '[from]', 
                                            $this->getDefaultValue('from'),
                                            array_merge($this->getAttributes(), 
                                                          array('id' => 'filter_' . $this->getFieldName() . '_from'))) 
               . "<br><span>" . $this->__('To:') . "</span>" 
               . $this->getView()->formText($this->getFieldName() . '[to]', 
                                            $this->getDefaultValue('to'), 
                                            array_merge($this->getAttributes(), 
                                                        array('id' => 'filter_' . $this->getFieldName() . '_to')));
    }
}