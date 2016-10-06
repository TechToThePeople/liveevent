<script>
{literal}
(function (_,participants,event_id) {
  cj(function($){
  $.each(participants, function(i, obj){
i//    $('#participant-select').append($('<option>').text(obj.first_name+" "+obj.last_name).attr('value', obj.id));
     obj.text=obj.first_name+" "+obj.last_name;
     obj.participant_id=obj.id;
     obj.id=i;
  });
  $('#participant-select').select2({
     placeholder: 'Select an option',
    data: participants,
//    formatSelection: renderAction,
//    formatResult: renderAction
  })
  $('#participant-select').on('change', function () {
  // Do something
  displayParticipant(participants[$(this).val()]);

  });

  function displayParticipant(p){
console.log(p);
    var badge = _.template($("#tpl_badge").val());
    $("#badge_recto").html(badge(p));
  };

});


}(CRM._,{/literal}{$participants_json},{$event->id}));
</script>
<div class="row">
  <div class="col-md-12">
    <form id="api-explorer">
      <label for="participant">{ts}Participant{/ts}</label>
      <input class="crm-form-select big required" id="participant-select" name="participant" type="text" />
    </form>
  </div>
</div>

<div class="row">
  <div class="col-md-12">
    <div id="badge_recto" class="badge"></div>
  </div>
</div>
<textarea id="tpl_badge">
<div class="status_<%= status_id %> role_<%= role_id %>">

<div class="name"><%= first_name %> <%= last_name %></div>

</textarea>
{literal}
<style>
  .badge {width:300px;height:250px;border:1px solid black;background:lightgrey;position:relative;}
  .name {position:absolute;top:25px;left:0;text-align:center;display:inline-block;width:100%;font-size:30px;}
</style>
{/literal}

