from django.urls import include, path

app_name = "api"

urlpatterns = [
    path("v1/", include("djf_test_app.api.v1.urls", namespace="v1")),
]
