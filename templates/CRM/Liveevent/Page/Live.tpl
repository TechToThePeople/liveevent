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

<div class="row" id="participant_row">
  <div class="col-md-12" id="events">
    <form id="participant">
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
/*.visible-print   Hidden     Visible
.hidden-print <
*/

@media all
{
  .page-break  { display:none; }
}

@media print
{
  .page-break  { display:block; page-break-before:always; }
}

#badge img,#vbadge img{visibility:hidden;}
#badge .active,#vbadge .active {display:block;position:absolute;left:0;top:0;width:100%;height:100%;z-index:1;visibility:visible}
#qrcode {position:absolute;top:5mm;right:5mm;z-index:10}

#display_name {display:block;font-size:25px;top:40mm;
text-align:center;z-index:10;
line-height:1.3em;
text-transform:uppercase;
left:5mm;
right:5mm;
position:absolute;
}
i
#second{font-size:15px;top:60mm;
left:5mm;right:5mm;
text-align:center;z-index:10;position:absolute;}
#badge_id {position:absolute;z-index:10;right:1mm;bottom:1mm;font-size:8px}

.separator, #badge_country {display:none;}


@media nokscreen {
 .badge {border:1px solid;width:97mm;height:85mm;position:absolute;top:330px;left:600px;}
  #badge_verso {display:none;visibility:hidden;position:absolute;top:300px;left:855px;height:97mm;width:86mm;}
#badge img,#vbadge img{visibility:hidden;width:100px;height:100px;}
#badge #qrcode img,#vbadge #qrcode img{visibility:visible;width:78px;height:78px;}
#b1,#b2 {visibility:hidden;}
#message  {display:none;}
#badge.status_2  {border:5px solid green;}
.status_1 {}
}

@media print {
  * {font-family:Helvetica, Arial, sans serif}

  #civicrm-menu, #toolbar,#printer-friendly,header,#form,#participant_row,h1.page-header, #civicrm-footer,#access{ visibility:hidden!important;text-shadow:none;display:none!important;}


  .badge {width:50%!important;height:86mm!important;position:fixed;bottom:0mm;left:0;visibility:visible!important;display:block;}
  #badge_verso {left:auto;right:0;}
  .badge * {text-transform:uppercase}
   .badge img {width:50%;height:86mm;z-index:2} 
.  .badge #qrcode img{visibility:visible;width:78px;height:78px;}
  aaa.vbadge {left:auto;right:0;} 

  

  aa.role_3 * {font-weight:bold;} /* dear firefox, why are you ignoring color:#fff but that #f00 is fine? */

  #all {position:fixed;display:block;visibility:visible;border:black 1px solid;top:0;right:0;bottom:0;left:0}
  #half {position:fixed;display:block;visibility:visible;border:black 1px solid;top:0;left:0;bottom:0;width:50%;}

#b1,#b2 {position:fixed;top:50mm;left:0mm;width:97mm;height:86mm;border:1px solid red;}
#b1 img,#b2 img {width:97mm;height:86mm;display:none;position:absolute;}
#b2 {position:fixed;top:40mm;left:50%; border:1px solid green;}

.fbadge div, .vbadge div {z-index:1000}


aa.role_3 * {color:#000}
}
</style>
{/literal}

