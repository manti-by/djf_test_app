from django.urls import path

from djf_test_app.api.v1.healthcheck.views import HealthcheckView

app_name = "v1"


urlpatterns = [
    path("healthcheck/", HealthcheckView.as_view(), name="healthcheck"),
]
