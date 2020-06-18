<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; UTF-8" %>
<div class="modal fade" id="tag-video-alert">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <button type="button" class="btn btn-danger btn-xs" data-dismiss="modal" aria-hidden="true">×</button>
          </div>
          <div class="panel-title">关联视频</div>
        </div>
      </div>
      <div class="panel-body">
          <table id="table-1" class="table table-striped table-bordered" width="100%">
            <thead>
            <tr>
              <th></th>
              <th>视频</th>
              <th>章节</th>
            </tr>
            </thead>
          </table>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="tag-plan-alert">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="panel panel-inverse">
        <div class="panel-heading">
          <div class="panel-heading-btn">
            <button type="button" class="btn btn-danger btn-xs" data-dismiss="modal" aria-hidden="true">×</button>
          </div>
          <div class="panel-title">关联计划</div>
        </div>
      </div>
      <div class="panel-body">
        <table id="table-2" class="table table-striped table-bordered" width="100%">
          <thead>
          <tr>
            <th></th>
            <th>计划</th>
          </tr>
          </thead>
        </table>
      </div>
    </div>
  </div>
</div>
