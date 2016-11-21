<script>
var roles={crmAPI entity='Participant' action='getoptions' sequential=0 field="participant_role_id"};

var margin_top={$margin_top} || 20;
var margin_right={$margin_right} || 8;
var margin_bottom={$margin_bottom} || 20;
var margin_left={$margin_left} || 8;

{literal}
var vm=null;
//var margin = [20,8,10,8];


var badgeURL="/ext/liveevent/images/3/";



(function (_,participants,event_id) {cj(function($){

  if (typeof jsPrintSetup !== "object") 
    CRM.alert('For best results, use Firefox and install <a href="http://jsprintsetup.mozdev.org/">jsprintsetup</a>');

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
    }, 
    computed: {
      badgeImage: function () {
        return badgeURL+this.role_id+".png";
      }
    },
    methods: {
      printBadge: function(e) {
    if (typeof jsPrintSetup == "object") {
       CRM.status('Printing...');
       jsPrintSetup.setOption('orientation', jsPrintSetup.kPortraitOrientation);
       jsPrintSetup.setPaperSizeData(9);
       jsPrintSetup.setOption('shrinkToFit', false);
       jsPrintSetup.setOption('printRange', jsPrintSetup.kRangeSpecifiedPageRange);
       jsPrintSetup.setOption('startPageRange', 1);
       jsPrintSetup.setOption('endPageRange', 1);
       jsPrintSetup.setOption('marginTop', margin_top);
       jsPrintSetup.setOption('marginRight', margin_right);
       jsPrintSetup.setOption('marginBottom', margin_bottom);
       jsPrintSetup.setOption('marginLeft', margin_left);
       jsPrintSetup.setOption('headerStrLeft', "Help spread the news");
       jsPrintSetup.setOption('headerStrCenter', '');
       jsPrintSetup.setOption('footerStrLeft', '');
       jsPrintSetup.setOption('footerStrCenter', 'Thanks for your participation');
       jsPrintSetup.clearSilentPrint();
       jsPrintSetup.setOption('printSilent', 1);
       // Do Print 
       // When print is submitted it is executed asynchronous and
       // script flow continues after print independently of completetion of print process! 
       jsPrintSetup.print();
       // next commands
    } else {
        CRM.alert('For best results, use Firefox and install <a href="http://jsprintsetup.mozdev.org/">jsprintsetup</a>');
        
    }
  }
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
    <button type="button" class="btn btn-primary btn-lg print_button" v-on:click="printBadge">
      <span class="glyphicon glyphicon-print" aria-hidden="true"></span> Print
    </button>
    <button type="button" class="btn btn-default btn-lg">
      <span class="glyphicon glyphicon-refresh" aria-hidden="true"></span> New
    </button>
    </form>
  </div>
  <div class="col-md-4">
    <div id="badge_recto" class="badge">
      <img :src="badgeImage" />
      <div class='name'>{{ first_name }} {{ last_name }}</div>
      <div class='org'>{{ organization_name }}</div>
    </div>
  </div>
  <div class="col-md-4">
    <div id="badge_verso" class="badge">
      <img :src="badgeImage" />
      <div class='name'>{{ first_name }} {{ last_name }}</div>
      <div class='org'>{{ organization_name }}</div>
    </div>
  </div>
</div>

<style>
  .badge {width:100%;height:250px;border:1px solid black;background:lightgrey;position:relative;}
  aa.name {position:absolute;top:3em;left:0;text-align:center;display:inline-block;width:100%;font-size:30px;}
  aa.org {position:absolute;top:7em;left:0;text-align:center;display:inline-block;width:100%;font-size:20px;}
/*.visible-print   Hidden     Visible
.hidden-print <
*/

@media all
{
  aa.page-break  { display:none; }
}

@media print
{
  aa.page-break  { display:block; page-break-before:always; }
}

aa.badge img {width:50%;height:86mm;z-index:2;display:block;position:absolute;top:0;left:0;} 
.badge img {display:block;position:absolute;left:0;top:0;width:100%;height:100%;z-index:1;visibility:visible}
#qrcode {position:absolute;top:5mm;right:5mm;z-index:10}

.name, #display_name {display:inline-block;font-size:25px;top:25mm;
text-align:center;z-index:10;
line-height:1.3em;
text-transform:uppercase;
left:5mm;
right:5mm;
position:absolute;
color:black;
}


.org, #second{font-size:15px;top:40mm;
left:5mm;right:5mm;
color:black;
text-align:center;z-index:10;
position:absolute;}

#badge_id {position:absolute;z-index:10;right:1mm;bottom:1mm;font-size:8px}

.separator, #badge_country {display:none;}



@media print {
  * {font-family:Helvetica, Arial, sans serif}

  #civicrm-menu, #toolbar,#printer-friendly,header,#form,#participant_row,h1.page-header, #civicrm-footer,#access{ visibility:hidden!important;text-shadow:none;display:none!important;}


  .badge {width:50%!important;height:86mm!important;position:fixed;bottom:0mm;left:0;visibility:visible!important;display:block;}
  #badge_verso {left:auto;right:0;}
  .badge * {text-transform:uppercase}
.  .badge #qrcode img{visibility:visible;width:78px;height:78px;}

  .name {top:30mm;}
  .org {top:50mm}}
}


.badge {
  
}

</style>
{/literal}

