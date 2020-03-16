from testapp.models import User
from django.shortcuts import render
from django.http import HttpResponse
from passlib.hash import pbkdf2_sha256

def index(request):
	template = 'index.html'
	return render(request,template)

def create_user(request):
	if request_method == 'POST':
		username = request.POST['username']
		password = request.POST['password']

		encrypt_password = pbkdf2_sha256.encrypt(password,rounds = 12000, salt_size = 32)

		User.objects.create(
			name = name,
			password = encrypt_password
		)

		return HttpResponse('')