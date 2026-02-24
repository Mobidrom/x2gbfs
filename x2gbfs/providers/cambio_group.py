import logging

from .cambio import CambioProvider

logger = logging.getLogger(__name__)

class CambioGroupProvider(CambioProvider):
    """
    The CambioGroupProvider retrieves (static) stations and vehicleClasses from Cambio API.
    """

    STATIONS_URL = 'https://cwapi.cambio-carsharing.com/opendata/v1/mandatorGroup/{city_id}/stations'
    VEHICLE_TYPES_URL = 'https://cwapi.cambio-carsharing.com/opendata/v1/mandatorGroup/{city_id}/vehicles'
