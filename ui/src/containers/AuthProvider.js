//@flow

import React, {
  useContext,
  useState,
  createContext,
  type Context,
  type Node,
} from 'react';

export type Auth = {
  access_token: string,
  expires_at: number,
  groups: string[],
  id_token: string,
  profile: Object,
  refresh_token: ?string,
  scope: string,
  session_state: ?string,
  state: ?string,
  token_type: string,
};

export const AuthContext: Context<{
  authContext: Auth | null,
  setAuthcontext: (newAuthContext: Auth) => void,
} | null> = createContext(null);

export function useAuth(): Auth | null {
  const auth = useContext(AuthContext);
  console.log(auth);
  if (!auth) {
    throw new Error(
      'auth is undefined, this may be because you forgot to wrap your component with <AuthProvider></AuthProvider>',
    );
  }
  return auth.authContext;
}

export function AuthProvider({ children }: { children: Node }): Node {
  // Local state to hold authContext and set it in Navbar child on Auth
  const [authContext, setAuthcontext] = useState<Auth | null>(null);

  return (
    <AuthContext.Provider value={{ authContext, setAuthcontext }}>
      {children}
    </AuthContext.Provider>
  );
}

export default AuthProvider;
