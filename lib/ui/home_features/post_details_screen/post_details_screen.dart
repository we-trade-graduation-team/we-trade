import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_colors.dart';
import '../../../models/arguments/shared/post_details_arguments.dart';
import '../../../models/cloud_firestore/post_model/post/post.dart';
import '../../../providers/loading_overlay_provider.dart';
import '../../../services/firestore/firestore_database.dart';
import 'local_widgets/post_details_body.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _arguments =
        ModalRoute.of(context)!.settings.arguments as PostDetailsArguments;

    final _postId = _arguments.postId;

    // final _ownerId = _arguments.ownerId;

    final _firestoreDatabase = context.watch<FirestoreDatabase>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.kScreenBackgroundColor,
      body: ChangeNotifierProvider<LoadingOverlayProvider>(
        create: (_) => LoadingOverlayProvider(),
        child: Consumer<LoadingOverlayProvider>(
          builder: (_, loadingOverlay, __) {
            return LoadingOverlay(
              isLoading: loadingOverlay.isLoading,
              color: Colors.white,
              opacity: 1,
              progressIndicator: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              child: MultiProvider(
                providers: [
                  FutureProvider<Post>.value(
                    value: _firestoreDatabase.getPost(
                      postId: _postId,
                    ),
                    initialData: Post.initialData(),
                    catchError: (_, __) => Post.initialData(),
                  ),
                  Provider<String>.value(
                    value: _postId,
                  ),
                  Provider<PostDetailsArguments>.value(
                    value: _arguments,
                  ),
                ],
                child: const PostDetailsBody(),
              ),
            );
          },
        ),
      ),
    );
  }
}
