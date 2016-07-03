function ping() {
    $.getJSON("list_approval", function (data) {
        data.forEach(function(element) {
            var exist = $("#heap_list option[value='" + element.url + "']").length > 0;
            if (!exist) {
                var opt = new Option("[" + element.dur + "s] " + element.title);
                opt.value = element.url;
                heap.append(opt);
            }
        }, this);
    });
    setTimeout(ping, 1000);
}

var heap = null;

$(document).ready(function() {
    heap = $("#heap_list");
    ping();
});

$('#heap_reject_button').click(function() {
    $.post("_in/reject.html", { 'urls': heap.val() });
    heap.val().forEach(function (el) {
        $("#heap_list option[value='" + el + "']").remove();
    });
});

$('#heap_approve_button').click(function() {
    $.post("_in/approve.html", { 'urls': heap.val() });
    heap.val().forEach(function (el) {
        $("#heap_list option[value='" + el + "']").remove();
    });
});

$("#prev").click(function() {
    $.post("_in/prev.html");
});

$("#pp").click(function() {
    $.post("_in/pp.html");
});

$("#play").click(function() {
    $.post("_in/play.html");
})

$("#next").click(function() {
    $.post("_in/next.html");
});

$("#save").click(function() {
    $.post("_in/save.html");
})

$("#load").click(function() {
    $.post("_in/load.html");
});