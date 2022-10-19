CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    upvotes INT DEFAULT 0 NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT null,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
ALTER TABLE users ADD CONSTRAINT users_email_key UNIQUE(email);
CREATE TABLE threads (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    body TEXT NOT NULL,
    title TEXT DEFAULT '' NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL,
    upvotes INT DEFAULT 0 NOT NULL,
    uid UUID NOT NULL,
    downvotes INT DEFAULT 0 NOT NULL,
    tid UUID NOT NULL
);
CREATE INDEX threads_created_at_index ON threads (created_at);
CREATE TABLE upvoterelations (
    uid UUID NOT NULL,
    tid UUID DEFAULT null,
    upvoted BOOLEAN NOT NULL
);
ALTER TABLE threads ADD CONSTRAINT threads_ref_tid FOREIGN KEY (tid) REFERENCES threads (id) ON DELETE NO ACTION;
ALTER TABLE threads ADD CONSTRAINT threads_ref_uid FOREIGN KEY (uid) REFERENCES users (id) ON DELETE NO ACTION;
ALTER TABLE upvoterelations ADD CONSTRAINT upvoterelations_ref_tid FOREIGN KEY (tid) REFERENCES threads (id) ON DELETE NO ACTION;
ALTER TABLE upvoterelations ADD CONSTRAINT upvoterelations_ref_uid FOREIGN KEY (uid) REFERENCES users (id) ON DELETE NO ACTION;
