
# Design and Responsive

## Background color
primary - blue
secondary - gray
success - green
danger - red
warning - yellow
info - cyan -light blue
dark
white
transparent
eg: bg-primary

## Containter and rows
container = required for default grid system
    <style>
        .myDiv {
            width: 100%;
            height: 100px;
        }
    </style>
<div class="container"> <!-- add margin and padding --> <!-- or container-fluid -->
    <div class="myDiv bg-success"></div>
</div>

## Media Breakpoints
min-width: 1200px - XL
min-width: 992px - LG
min-width: 768px - MD
min-width: 576px - SM
max-width: 575.98px - xtra-SM
<style type="text/css">
    @media(min-width: 576px){body{background: cyan;}}
</style>

## Grid system
<style type="text/css">
    div {
        margin-top: 20px;
        border: 1px solid #000;
    }
</style>
<section class="container">
    <section class="row">
        <div class="col bg-primary">text</div>
        <div class="col bg-warning">text</div>
        <div class="col bg-primary">text</div>
        <div class="col bg-warning">text</div>
    </section>
</section>

# Forms
<form>
<div class="form-row"> <!-- more compact row -->
<div class="form-group">  <!-- form-group to input el -->
    <label for="name">Name</label>
    <input class="form-control" type="text" id="name"> <!-- form-control -->
</div>
</div>
</form>
