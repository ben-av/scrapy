$(document).ready(function() {
    $('#rules_container').on('click', '.remove_site_rule', removeRule);
    $('#scrape_url').click(scrapeUrl);
    $('#add_rule').click(openAddRuleModal);
    $('#saveRule').click(function(){
    	$('form#addRuleForm #submitAddRule').click();
    });
    setFormValidation();
    setTimeout(function() {
        $('.alert.alert-success').hide();
    }, 1500);
});

function setFormValidation() {
	$('form#addRuleForm').submit(function(event){
		if(this.checkValidity())
        {
        	event.preventDefault();
            addRule();
        }
	});
}

function openAddRuleModal()
{
    clearRule();
    $('.modal').modal('show');
    setTimeout(function(){$('#propName').focus();}, 500);
}

function addRule() {
    var site_rules_hidden = $('#site_rules');
    var site_rules = JSON.parse(site_rules_hidden.val() || "{}");
    var newRule = {
        rule: $("#propRule").val(),
        attribute: $("#propAttr").val()
    };
    var propName = $("#propName").val();
    site_rules[propName] = newRule;

    var html = $('<div class="list-group-item rules_list"></div>');
    html.append('<span class="glyphicon glyphicon-remove pull-right remove_site_rule" aria-hidden="true" data-prop-name="' +
        propName + '>"</span>');

    html.append('<h4>' + propName + '</h4>');
    html.append('<p class="list-group-item-text"> Rule:' + newRule.rule + "</p>");
    html.append('<p class="list-group-item-text"> Attribute:' + newRule.attribute + "</p>");
    $("#rules_container").append(html);
    site_rules_hidden.val(JSON.stringify(site_rules));

    $('.modal').modal('hide');
}

function clearRule()
{
    $('#propName').val('');
    $('#propRule').val('');
    $('#propAttr').val('');
}

function removeRule(event) {
    var site_rules_hidden = $('#site_rules');
    var site_rules = JSON.parse(site_rules_hidden.val());

    delete site_rules[$(this).data("prop-name")];
    site_rules_hidden.val(JSON.stringify(site_rules));
    $(this).parent().remove();
}

function scrapeUrl() {
    var urlToCheck = $('#urlText').val();
    window.location = '/scrape/test?url=' + urlToCheck;
}
