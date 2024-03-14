from channels.routing import ProtocolTypeRouter, URLRouter
from channels.auth import AuthMiddlewareStack
from NF import routing as NF_routing
from django.core.asgi import get_asgi_application

application = ProtocolTypeRouter({
    # HTTP routing
    "http": get_asgi_application(),

    # WebSocket routing
    "websocket": AuthMiddlewareStack(
        URLRouter(
            NF_routing.websocket_urlpatterns
        )
    ),
})