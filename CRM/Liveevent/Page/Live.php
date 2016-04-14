<?php

require_once 'CRM/Core/Page.php';

class CRM_Liveevent_Page_Live extends CRM_Core_Page {
  function run() {
    // Example: Set the page-title dynamically; alternatively, declare a static title in xml/Menu/*.xml

  $api= new civicrm_api3();
  $event_id=$event_id + 0;
  if ($event_id ==0) {
    die (" civicrm/event/live/{event_id}");
  }
  if (!$api->OptionGroup->GetSingle (array('name'=>'participant_role'))){
    die ("FATAL: ".$api->attr('error_message'));
  }
  $role_group = $api->attr('id');
  if (!$api->OptionValue->Get (array('option_group_id'=>$role_group))){
    die ("FATAL: ".$api->attr('error_message'));
  }
  if (defined( 'TTTP_LISTING_FIX_JQUERY_CONFLICT'))
    $this->assign('currentTime', date('Y-m-d H:i:s'));
    $this->assign('cj',"jQuery");
  else  
    $this->assign('cj',"cj");
  $this->assign('role',$api->values());
  if (!$api->Event->GetSingle ($event_id)){
    die ("FATAL: ".$api->attr('error_message'));
  }
  CRM_Utils_System::setTitle($api->attr('title'));;
  $this->assign('event',$api->result());
  //if (!$api->Participant->Get(array('event_id'=>$event_id, 'option.limit'=>10000))){
  if (!$api->Participant->GetFull(array('event_id'=>$event_id, 'option.limit'=>10000))){
    die ("FATAL: ".$api->attr('error_message'));
  }
  $people = $api->values();
  $this->assign('total',count($people));
  $this->assign('participants_json',json_encode($people));
  $this->assign('tttp_root', drupal_get_path('module', 'tttp_listing') );


    parent::run();
  }
}
