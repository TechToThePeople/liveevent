<script>
{literal}
var vm=null;
(function (_,participants,event_id) {cj(function($){

  $('#participant-select').select2({
    placeholder: 'Select a participant',
    data:participants,
    matcher: function (term, text,o) {
      if (o.first_name.toUpperCase().indexOf(term.toUpperCase()) == 0) {
      return true;
      }
      if (o.last_name.toUpperCase().indexOf(term.toUpperCase()) == 0) {
      return true;
      }
      if (o.organization_name.toUpperCase().indexOf(term.toUpperCase()) == 0) {
      return true;
      }
      if (o.country.toUpperCase().indexOf(term.toUpperCase()) == 0) {
      return true;
      }
    },
    formatSelection: function (d) { return d.first_name+" "+d.last_name+ " <i>"+d.organization_name+"</i>"; },
    formatResult: function (d) { return d.first_name+" "+d.last_name+ " <i>"+d.organization_name+"</i>"; }
  })
  .on('change', function (e) {
      var d =e.added;
      for (var k in d) {
        vm[k] = d[k];
      }

  });

  vm = new Vue({
  el: '#badge',
  data: {
   first_name:"First",
   last_name:"Last",
   organization_name:"Org"
    } 
  });
});}(CRM._,{/literal}{$participants_json},{$event->id}));
{literal}
</script>

<div class="row" id="eventsss">
  <div class="col-md-12" id="events">
    <form id="api-explorer">
      <label for="participant">Participant</label>
      <input id="participant-select"/>
    </form>
  </div>
</div>

<div class="row" id="badge">
  <div class="col-md-3" id="form">
    <form><br>
    <div class="form-group">
    <input v-model="first_name" placeholder="first">
    </div><div class="form-group">
    <input v-model="last_name" placeholder="last">
    </div><div class="form-group">
    <input v-model="organization_name" placeholder="last">
    </div>
    <button type="button" class="btn btn-primary btn-lg">
      <span class="glyphicon glyphicon-print" aria-hidden="true"></span> Print
    </button>
    <button type="button" class="btn btn-default btn-lg">
      <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> New
    </button>
    </form>
  </div>
  <div class="col-md-6">
    <div id="badge_recto" class="badge">
      <div class='name'>{{ first_name }} {{ last_name }}</div>
      <div class='org'>{{ organization_name }}</div>
    </div>
  </div>
  <div class="col-md-3">
    <div id="badge_verso" class="badge">
      <div class='name'>{{ first_name }} {{ last_name }}</div>
      <div class='org'>{{ organization_name }}</div>
    </div>
  </div>
</div>

<style>
  .badge {width:100%;height:250px;border:1px solid black;background:lightgrey;position:relative;}
  .name {position:absolute;top:3em;left:0;text-align:center;display:inline-block;width:100%;font-size:30px;}
  .org {position:absolute;top:7em;left:0;text-align:center;display:inline-block;width:100%;font-size:20px;}
</style>
{/literal}

