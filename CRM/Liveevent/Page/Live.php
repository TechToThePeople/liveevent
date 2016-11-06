<?php

require_once 'CRM/Core/Page.php';
require_once 'api/class.api.php';

class CRM_Liveevent_Page_Live extends CRM_Core_Page {
  function run() {
    // Example: Set the page-title dynamically; alternatively, declare a static title in xml/Menu/*.xml
  CRM_Core_Resources::singleton()
    ->addScriptFile('eu.tttp.liveevent', 'node_modules/vue/dist/vue.js')
    ->addScriptFile('eu.tttp.liveevent', 'node_modules/vue-select/dist/vue-select.js')
  ;
    


  $api= new civicrm_api3();
  $event_id= CRM_Utils_Request::retrieve('event_id', 'Positive');
  if ($event_id ==0) {
    die (" civicrm/event/live?event_id={event_id}");
  }
  if (!$api->OptionValue->Get (array('option_group_id'=>'participant_role'))){
    die ("FATAL: ".$api->attr('error_message'));
  }
  $this->assign('role',$api->values());
  if (!$api->Event->GetSingle (array("event_id"=>$event_id))){
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


    parent::run();
  }
}
