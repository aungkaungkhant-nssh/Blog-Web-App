<%@ include file="include/header.jsp" %>
	
	<section class="container mt-5">
			<div class="row">
				<div class="col-md-6 offset-md-3">
					<div class="card shadow">
						<div class="card-body ">
							<h3 class="text-center pb-3">Add Post</h3>
							<form    action="AddPostServlet" method="post" enctype="multipart/form-data">
								<div class="form-group">
									<input type="text" name="title"  placeholder="Title" class="form-control"/>
								</div>
								<div class="form-group">
									<input type="file" name="file" class="form-control"/>
								</div>
								<div class="form-group">
									<textarea col='12' row="12" class="form-control" name="description" placeholder="Description"></textarea>
								</div>
								<button type="submit" class="btn btn-primary btn-block">Add Posts</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			
	</section>
<%@ include file="include/footer.jsp" %>
