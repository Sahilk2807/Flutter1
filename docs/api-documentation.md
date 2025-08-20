# GP SIR EDUCATION - API Documentation

Base URL: `https://your-api-domain.com/api`

All API responses follow this format:
```json
{
  "ok": true|false,
  "data": {...},
  "error": "Error message if ok is false"
}
```

## Authentication

All protected endpoints require a Firebase ID token in the Authorization header:
```
Authorization: Bearer <firebase_id_token>
```

## User Endpoints

### POST /auth/verify
Verify Firebase ID token and get user claims.

**Headers:**
- `Authorization: Bearer <token>`

**Response:**
```json
{
  "ok": true,
  "data": {
    "uid": "firebase_uid",
    "email": "user@example.com",
    "email_verified": true,
    "name": "User Name"
  }
}
```

### GET /profile/me
Get current user's profile.

**Headers:**
- `Authorization: Bearer <token>`

**Response:**
```json
{
  "ok": true,
  "data": {
    "firebase_uid": "uid",
    "email": "user@example.com",
    "name": "John Doe",
    "mobile": "9876543210",
    "address": "123 Main St",
    "class": "Class 12",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

### POST /profile/upsert
Create or update user profile.

**Headers:**
- `Authorization: Bearer <token>`
- `Content-Type: application/json`

**Body:**
```json
{
  "name": "John Doe",
  "mobile": "9876543210",
  "address": "123 Main Street, City",
  "class": "Class 12"
}
```

**Response:**
```json
{
  "ok": true,
  "data": {
    "firebase_uid": "uid",
    "email": "user@example.com",
    "name": "John Doe",
    "mobile": "9876543210",
    "address": "123 Main Street, City",
    "class": "Class 12",
    "created_at": "2024-01-01T00:00:00Z",
    "updated_at": "2024-01-01T00:00:00Z"
  }
}
```

### POST /contact
Submit contact form message.

**Headers:**
- `Content-Type: application/json`

**Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "message": "This is my message to support team."
}
```

**Response:**
```json
{
  "ok": true,
  "data": {
    "message": "Contact message submitted successfully"
  }
}
```

## Admin Endpoints

All admin endpoints require admin privileges.

### GET /admin/users
List all users with pagination.

**Headers:**
- `Authorization: Bearer <admin_token>`

**Query Parameters:**
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 20, max: 100)
- `search` (optional): Search term for name, email, or mobile

**Response:**
```json
{
  "ok": true,
  "data": {
    "users": [
      {
        "firebase_uid": "uid",
        "email": "user@example.com",
        "name": "John Doe",
        "mobile": "9876543210",
        "address": "123 Main St",
        "class": "Class 12",
        "created_at": "2024-01-01T00:00:00Z",
        "updated_at": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 100,
      "pages": 5
    }
  }
}
```

### GET /admin/users/{uid}
Get specific user details.

**Headers:**
- `Authorization: Bearer <admin_token>`

**Response:**
```json
{
  "ok": true,
  "data": {
    "user": {
      "firebase_uid": "uid",
      "email": "user@example.com",
      "name": "John Doe",
      "mobile": "9876543210",
      "address": "123 Main St",
      "class": "Class 12",
      "created_at": "2024-01-01T00:00:00Z",
      "updated_at": "2024-01-01T00:00:00Z"
    },
    "enrollments": [
      {
        "id": 1,
        "course_id": 1,
        "course_title": "Mathematics Course",
        "subject": "Mathematics",
        "course_class": "Class 12",
        "enrolled_at": "2024-01-01T00:00:00Z",
        "progress_percentage": 75.50
      }
    ]
  }
}
```

### GET /admin/contacts
List all contact messages.

**Headers:**
- `Authorization: Bearer <admin_token>`

**Query Parameters:**
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 20, max: 100)

**Response:**
```json
{
  "ok": true,
  "data": {
    "contacts": [
      {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "message": "This is a contact message.",
        "created_at": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 20,
      "total": 50,
      "pages": 3
    }
  }
}
```

### DELETE /admin/contacts/{id}
Delete a contact message.

**Headers:**
- `Authorization: Bearer <admin_token>`

**Response:**
```json
{
  "ok": true,
  "data": {
    "message": "Contact message deleted successfully"
  }
}
```

### POST /admin/add
Add a new admin user.

**Headers:**
- `Authorization: Bearer <admin_token>`
- `Content-Type: application/json`

**Body:**
```json
{
  "firebase_uid": "user_firebase_uid",
  "note": "Added as content moderator"
}
```

**Response:**
```json
{
  "ok": true,
  "data": {
    "message": "Admin added successfully",
    "firebase_uid": "user_firebase_uid"
  }
}
```

### POST /admin/remove
Remove admin privileges from a user.

**Headers:**
- `Authorization: Bearer <admin_token>`
- `Content-Type: application/json`

**Body:**
```json
{
  "firebase_uid": "admin_firebase_uid"
}
```

**Response:**
```json
{
  "ok": true,
  "data": {
    "message": "Admin removed successfully",
    "firebase_uid": "admin_firebase_uid"
  }
}
```

### POST /admin/notify
Send push notification to users.

**Headers:**
- `Authorization: Bearer <admin_token>`
- `Content-Type: application/json`

**Body:**
```json
{
  "title": "New Course Available",
  "body": "Check out our latest Mathematics course!",
  "target": "all",
  "data": {
    "course_id": "123",
    "action": "open_course"
  }
}
```

**Target Options:**
- `"all"`: Send to all users
- `"class"`: Send to specific class (requires `class` field)
- `"specific_users"`: Send to specific users (requires `user_ids` array)

**Response:**
```json
{
  "ok": true,
  "data": {
    "message": "Notification sent successfully",
    "sent_count": 150,
    "failed_count": 5,
    "total_tokens": 155
  }
}
```

## Error Codes

- `400`: Bad Request - Invalid input data
- `401`: Unauthorized - Invalid or missing token
- `403`: Forbidden - Insufficient privileges
- `404`: Not Found - Resource not found
- `405`: Method Not Allowed - HTTP method not supported
- `409`: Conflict - Resource already exists
- `500`: Internal Server Error - Server error

## Rate Limiting

API requests are limited to 100 requests per hour per IP address. Exceeded limits will return:

```json
{
  "ok": false,
  "error": "Rate limit exceeded. Try again later."
}
```

## Examples

### cURL Examples

**Get user profile:**
```bash
curl -X GET https://your-api-domain.com/api/profile/me \
  -H "Authorization: Bearer YOUR_FIREBASE_TOKEN"
```

**Update profile:**
```bash
curl -X POST https://your-api-domain.com/api/profile/upsert \
  -H "Authorization: Bearer YOUR_FIREBASE_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "mobile": "9876543210",
    "address": "123 Main St",
    "class": "Class 12"
  }'
```

**Send notification (admin):**
```bash
curl -X POST https://your-api-domain.com/api/admin/notify \
  -H "Authorization: Bearer ADMIN_FIREBASE_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "New Course",
    "body": "Mathematics course is now available!",
    "target": "all"
  }'
```

### JavaScript Examples

**Using fetch API:**
```javascript
// Get user profile
const response = await fetch('https://your-api-domain.com/api/profile/me', {
  headers: {
    'Authorization': `Bearer ${firebaseToken}`
  }
});
const data = await response.json();

// Update profile
const updateResponse = await fetch('https://your-api-domain.com/api/profile/upsert', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${firebaseToken}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    name: 'John Doe',
    mobile: '9876543210',
    address: '123 Main St',
    class: 'Class 12'
  })
});
```

## Testing

Use the provided Postman collection or test with curl commands. Ensure you have:

1. Valid Firebase ID tokens
2. Admin user set up in database
3. Proper CORS configuration
4. Database connection working

For testing Firebase tokens, use the Firebase Auth REST API or generate tokens from your app.

