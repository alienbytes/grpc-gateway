package server

import (
	"context"
	"sync"

	auth "github.com/Feedbackify/gateway/proto"
)

// Backend implements the protobuf interface
type Backend struct {
	mu *sync.RWMutex
	auth.UnimplementedAuthServiceServer
}

// New initializes a new Backend struct.
func New() *Backend {
	return &Backend{
		mu: &sync.RWMutex{},
	}
}

// AddUser adds a user to the in-memory store.
func (b *Backend) Register(ctx context.Context, _ *auth.RegisterRequest) (*auth.RegisterResponse, error) {
	b.mu.Lock()
	defer b.mu.Unlock()

	return &auth.RegisterResponse{
		UserId: "123213213213",
	}, nil
}

func (b *Backend) Login(ctx context.Context, _ *auth.LoginRequest) (*auth.LoginResponse, error) {
	b.mu.Lock()
	defer b.mu.Unlock()

	return &auth.LoginResponse{
		AccessToken:  "asdasd",
		RefreshToken: "asdasda",
	}, nil
}
